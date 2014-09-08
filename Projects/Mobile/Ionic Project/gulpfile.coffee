
# ==================================
# Imports
# ==================================
gulp                  = require 'gulp'
gutil                 = require 'gulp-util'
bower                 = require 'bower'
concatPlugin          = require 'gulp-concat'
sassPlugin            = require 'gulp-ruby-sass'
minifyCssPlugin       = require 'gulp-minify-css'
rename                = require 'gulp-rename'
shellPlugin           = require 'shelljs'
coffeePlugin          = require 'gulp-coffee'
ifPlugin              = require 'gulp-if'
cleanPlugin           = require 'gulp-clean'
karmaPlugin           = require 'gulp-karma'
spaPlugin             = require 'gulp-spa'
uglifyPlugin          = require 'gulp-uglify'
htmlMinPlugin         = require 'gulp-htmlmin'
plumberPlugin         = require 'gulp-plumber'
watchPlugin           = require 'gulp-watch'
liveReloadPlugin      = require 'gulp-livereload'
includeSourcesPlugin  = require 'gulp-include-source'
_                     = require 'lodash'
useminPlugin          = require 'gulp-usemin'
frepPlugin            = require 'gulp-frep'



# ==================================
# General Variables
# ==================================
projectName = 
  fileName     : 'project-name'
  officialName : 'OfficialProjectName'

# ==================================
# Path Variables
# ==================================

vendors =
  sass:
    sourceFiles : 'vendors/styles/**/*.{sass, scss}'
    mainSassFile: 'vendors/styles/vendors.sass'
  scripts: 'vendors/scripts/*.js'

source =
  coffee:
    sourceFiles : ['src/coffee/**/*.coffee']
  sass:
    sourceFiles : 'src/styles/**/*.{sass, scss}'
    mainSassFile: "src/styles/#{projectName.fileName}.sass"
  html:
    sourceFiles : 'src/views/**/*.html'
  img:
    sourceFiles : 'src/img/**/*'
  resourcesFiles: 'src/resources/**/*'
  indexFile: 'src/index.html'

openfb =
  js   : 'vendors/scripts/openFB/*.js'
  html : 'vendors/scripts/openFB/*.html'

LIVE_RELOAD_PORT = 35729

dist =
  directory          : 'www/'
  jsDirectory        : 'www/scripts/'
  cssDirectory       : 'www/styles/'
  htmlDirectory      : 'www/views/'
  imgDirectory       : 'www/img/'
  indexFile          : 'www/index.html'
  libsDirectory      : 'www/lib/'
  resourcesDirectory : 'www/resources/'
  files              : ['www/scripts/**/*', 'www/styles/**/*', 'www/views/**/*', 'www/img/**/*', 'www/index.html']

spec =
  coffee:
    sourceFiles : ['spec/coffee/**/*.coffee']
  js:
    directory   : 'spec/js'
    sourceFiles : [
      'www/lib/jquery/jquery.min.js'
      'www/lib/underscore/underscore.js'
      'www/lib/ionic/js/ionic.bundle.min.js'
      'www/lib/angular-route/angular-route.js'
      'http://codeorigin.jquery.com/jquery-1.10.2.min.js'
      'www/lib/angular-ui-router/release/angular-ui-router.min.js'
      'www/lib/angular-mocks/angular-mocks.js'
      'www/lib/angular-sanitize/angular-sanitize.min.js'
      'www/scripts/**/*.js'
      'www/scripts/*.js'
      'spec/**/*.js'
    ]


# ==================================
# Vendors
# ==================================

# Build SASS
# ======================
gulp.task 'buildVendorsStyles', ->
  gulp.src vendors.sass.mainSassFile
    .pipe sassPlugin()
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: 'vendors', extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory

gulp.task 'buildVendorsScripts', ->
  gulp.src vendors.scripts
    .pipe gulp.dest(dist.libsDirectory)

# Install Bower Components
# ======================
gulp.task 'install', ['gitCheck'], ->

  unless shellPlugin.which('bower')
    gutil.log gutil.colors.red '=== BOWER IS NOT INSTALLED === ..Abort!!'
    process.exit 1


  bower.commands.prune()
    .on 'log', (data) ->
      gutil.log '[Bower Prune]', gutil.colors.cyan data.id, data.message


  bower.commands.install()
    .on 'log', (data) ->
      gutil.log '[Bower Install]', gutil.colors.cyan data.id, data.message


# Check git installation
# ======================
gulp.task 'gitCheck', (done) ->
  unless shellPlugin.which 'git'
    gutil.log("""
      #{gutil.colors.red('Git is not installed.')}
      \n Git, the version control system, is required to download dependencies."""
    )
    process.exit 1
  done()

# Copy OpenFB files to Dist
# ======================
gulp.task 'copyOpenFBFilesToDistFolder', ->
  gulp.src(openfb.js)
    .pipe gulp.dest(dist.libsDirectory)

  gulp.src(openfb.html)
    .pipe gulp.dest(dist.directory)

# ==================================
# Source
# ==================================

# Build SASS
# ======================
buildAppStylesFunction = () ->
  gulp.src source.sass.mainSassFile
    .pipe plumberPlugin()
    .pipe sassPlugin()
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: "#{projectName.fileName}", extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory

gulp.task 'buildAppStyles', [], buildAppStylesFunction


# Build CoffeeScript
# ======================
buildAppScriptsFunction = () ->
  gulp.src source.coffee.sourceFiles
    .pipe plumberPlugin()
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest dist.jsDirectory

gulp.task 'buildAppScripts', [], buildAppScriptsFunction



# Build HTML
# ======================
gulp.task 'buildMarkup', ->
  gulp.src(source.html.sourceFiles)
    .pipe gulp.dest(dist.htmlDirectory)

# Copy index.html
# ======================
gulp.task 'copyIndexToDistFolder', ['copyResourcesToDistFolder'], ->
  gulp.src(source.indexFile)
    .pipe gulp.dest(dist.directory)

# Copy Images to Dist
# ======================
gulp.task 'copyImgToDistFolder', ->
  gulp.src(source.img.sourceFiles)
    .pipe gulp.dest(dist.imgDirectory)

# Copy Resources
# ======================
gulp.task 'copyResourcesToDistFolder', ->
  gulp.src(source.resourcesFiles)
    .pipe gulp.dest(dist.resourcesDirectory)


# Include Sources from a list
# ======================
includeSourcesFunction = () ->

  gulp.src dist.indexFile
    .pipe includeSourcesPlugin({ cwd: dist.directory })
    .pipe gulp.dest(dist.directory)

gulp.task 'includeSources', ['copyIndexToDistFolder'], includeSourcesFunction


# Watch Files
# ======================
gulp.task 'watch', ['buildAppStyles', 'buildAppScripts', 'buildMarkup', 'copyIndexToDistFolder', 'copyImgToDistFolder', 'copyOpenFBFilesToDistFolder'], ->

  liveReloadPlugin.listen(LIVE_RELOAD_PORT)
  gulp.watch(dist.files).on 'change', liveReloadPlugin.changed


  watchPlugin(name: '[SassWatcher]', glob: source.sass.sourceFiles, buildAppStylesFunction)

  watchPlugin(name: '[CoffeeWatcher]', glob: source.coffee.sourceFiles, buildAppScriptsFunction)

  gulp.watch source.html.sourceFiles, ['buildMarkup']
    .on 'change', (e) ->
      gutil.log gutil.colors.cyan('[htmlWatcher]') + ' File ' + e.path + ' was ' + e.type + ', building again...'

  gulp.watch source.indexFile, ['copyIndexToDistFolder', 'includeSources']
    .on 'change', (e) ->
      gutil.log gutil.colors.cyan('[indexFileWatcher]') + ' Index file was ' + e.type + ', building again...'

  gulp.watch source.img.sourceFiles, ['copyImgToDistFolder']
    .on 'change', (e) ->
      gutil.log gutil.colors.cyan('[copyImgToDistFolder]') + ' Image file was ' + e.type + ', building again...'

  gulp.watch source.img.sourceFiles, ['copyOpenFBFilesToDistFolder']
    .on 'change', (e) ->
      gutil.log gutil.colors.cyan('[copyOpenFBFilesToDistFolder]') + ' OpenFB files were ' + e.type + ', building again...'



# ==================================
# Distribuition
# ==================================

# Clean Dist Directories
# ======================
gulp.task 'cleanDist', ->

  gulp.src(dist.cssDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.jsDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.htmlDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.imgDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.resourcesDirectory)
    .pipe cleanPlugin(force: yes)


# Build index.html
# ======================
gulp.task 'buildIndexFile', ['copyIndexToDistFolder', 'buildAppStyles', 'buildAppScripts', 'buildMarkup', 'includeSources'], ->
  gulp.src(dist.indexFile)
    .pipe(
      useminPlugin(
        main: [htmlMinPlugin()]

        js: [
          uglifyPlugin()
          concatPlugin("#{projectName.fileName}.js")
        ]
      )
    )
    .pipe(gulp.dest(dist.directory))



# replace OS Constant Function
# ======================
replaceCurrentDeviceOSConstantFunction = (currentOSValue) ->
  pattern = [
    pattern     : /(PM_CURRENT_DEVICE_OS_VALUE)/
    replacement : "#{currentOSValue}"
  ]

  gulp.src 'www/scripts/app.js'
    .pipe frepPlugin(pattern)
    .pipe gulp.dest(dist.jsDirectory)
    

# Build to iOS
# ======================
buildToIOSFunction = ->
  shellPlugin.exec 'ionic build ios'

gulp.task 'ionicBuildToIOS', ['default', 'replaceCurrentDeviceOSConstantToIOS'], buildToIOSFunction


# Replace OS constant to iOS
# ======================
gulp.task 'replaceCurrentDeviceOSConstantToIOS', ['default'], ->
  replaceCurrentDeviceOSConstantFunction('iOS')
  

# Run iOS emulator
# ======================
emulateIOSFunction = ->
  shellPlugin.exec 'ionic emulate ios'

gulp.task 'ionicEmulateIOS', ['buildIOS'], emulateIOSFunction


# Build to iOS
# ======================
buildToAndroidFunction = ->
  shellPlugin.exec 'ionic build android'

gulp.task 'ionicBuildToAndroid', ['default', 'replaceCurrentDeviceOSConstantToAndroid'], buildToAndroidFunction


# Replace OS constant to Android
# ======================
gulp.task 'replaceCurrentDeviceOSConstantToAndroid', ['default'], ->
  replaceCurrentDeviceOSConstantFunction('android')


# Flash android emulator
# ======================
flashAndroidFunction = ->
  shellPlugin.exec 'ionic run android'
  process.exit(0)

gulp.task 'ionicFlashAndroid', ['buildAndroid'], flashAndroidFunction


# ==================================
# Spec
# ==================================

# Watch specs files
# ======================
gulp.task 'watchSpecs', ['buildSpecScripts'], ->
  gulp.watch source.coffee.sourceFiles    , ['buildSpecScripts']


# Build CoffeeScript
# ======================
gulp.task 'buildSpecScripts', [], ->
  gulp.src spec.coffee.sourceFiles
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest spec.js.directory


# RunAppTests
# ======================
gulp.task 'runAppTests', ['buildSpecScripts'], () ->
  gulp.src(spec.js.sourceFiles)
    .pipe( karmaPlugin
      configFile: 'karma.conf.js'
      action    : 'run'
    )
    .on 'error', (err) ->
      console.log 'runAppTests: ' + err





# ==================================
# Register Macro Tasks
# ==================================
gulp.task 'default' , [
  'install'
  'buildAppStyles'
  'buildAppScripts'
  'buildMarkup'
  'copyResourcesToDistFolder'
  'copyIndexToDistFolder'
  'includeSources'
  'copyImgToDistFolder'
  'copyOpenFBFilesToDistFolder'
  'buildVendorsStyles'
  'buildVendorsScripts'
]

gulp.task 'dev'     , ['default', 'watch']

gulp.task 'build'  , ['default']
gulp.task 'dist'   , ['build']

gulp.task 'buildIOS'  , ['default' , 'replaceCurrentDeviceOSConstantToIOS','ionicBuildToIOS']
gulp.task 'emulateIOS', ['buildIOS','ionicEmulateIOS']

gulp.task 'buildAndroid'  , ['default', 'replaceCurrentDeviceOSConstantToAndroid', 'ionicBuildToAndroid']
gulp.task 'flashAndroid'  , ['buildAndroid','ionicFlashAndroid']

gulp.task 'test'  , ['buildSpecScripts', 'runAppTests']


