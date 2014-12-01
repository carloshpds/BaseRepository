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
htmlMinPlugin         = require 'gulp-minify-html'
plumberPlugin         = require 'gulp-plumber'
watchPlugin           = require 'gulp-watch'
liveReloadPlugin      = require 'gulp-livereload'
includeSourcesPlugin  = require 'gulp-include-source'
minifyImagesPlugin    = require 'gulp-imagemin'
revPlugin             = require 'gulp-rev'
_                     = require 'lodash'
useminPlugin          = require 'gulp-usemin'
frepPlugin            = require 'gulp-frep'
obfuscatePlugin       = require 'gulp-obfuscate'
regexReplacePlugin    = require 'gulp-regex-replace'


# ==================================
# General Variables
# ==================================
projectName =
  fileName     : 'project-name'
  officialName : 'ProjectName'

LIVE_RELOAD_PORT = 35729

envVariableFormat =
  preTextSalt : '__'
  posTextSalt : '__'

buildMode =
  dev  : 'Dev'
  prod : 'Prod'

# Dev Variables
# ======================
envDevVariables =
  APP_CURRENT_IP : 'localhost:8080'
  APP_ANALYTICS  : 'UA-DEV-CODE'

# Prod Variables
# ======================
envProdVariables =
  APP_CURRENT_IP : 'PROD-IP'
  APP_ANALYTICS  : 'UA-PROD-CODE'

# ==================================
# Path Variables
# ==================================

bowerDirectory = 'bower_components/**/*'

vendors =
  scripts      : 'vendors/scripts/*.js'
  sass:
    sourceFiles : 'vendors/styles/**/*.{sass, scss}'
    mainSassFile: 'vendors/styles/vendors.sass'
  css :
    sourceFiles : 'vendors/styles/**/*.css'

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

dist =
  directory          : 'dist/'
  jsDirectory        : 'dist/scripts/'
  cssDirectory       : 'dist/styles/'
  htmlDirectory      : 'dist/views/'
  imgDirectory       : 'dist/img/'
  indexFile          : 'dist/index.html'
  libsDirectory      : 'dist/libs/'
  resourcesDirectory : 'dist/resources/'
  resourcesFiles     :
    fonts  : 'dist/resources/fonts/**/*'
    flex   : 'dist/resources/flex-resources/prod-flex/**/*'
    videos : 'dist/resources/videos/**/*'
  files              : ['dist/scripts/**/*', 'dist/styles/**/*', 'dist/views/**/*', 'dist/img/**/*', 'dist/index.html']
  vendorsCssFile     : 'dist/styles/vendors.min.css'
  jsFiles            : 'dist/scripts/**/*'
  cssFiles           : 'dist/styles/**/*'
  htmlFiles          : 'dist/views/**/*'
  imgFiles           : 'dist/img/**/*'

release =
  directory           : 'release/'
  indexFile           : 'release/index.html'
  htmlDirectory       : 'release/views/'
  htmlFiles           : 'release/views/**/*'
  cssDirectory        : 'release/styles/'
  cssFiles            : 'release/styles/**/*'
  jsDirectory         : 'release/scripts/'
  jsFiles             : 'release/scripts/**/*'
  imgDirectory        : 'release/img/'
  imgFiles            : 'release/img/**/*'
  resourcesDirectory  :
    fonts  : 'release/resources/fonts/'
    flex   : 'release/resources/flex-resources/prod-flex/'
    videos : 'release/resources/videos/'
  resourcesFiles  :
    fonts  : 'release/resources/fonts/**/*'
    flex   : 'release/resources/flex-resources/prod-flex/**/*'
    videos : 'release/resources/videos/**/*'

spec =
  coffee:
    sourceFiles : ['spec/coffee/**/*.coffee']
  js:
    directory   : 'spec/js'
    sourceFiles : [
      'dist/libs/angular/angular.js',
      'dist/libs/jquery/jquery.min.js',
      'dist/libs/underscore/underscore.js',
      'dist/libs/angular-ui-router/release/angular-ui-router.min.js',
      'dist/libs/angular-mocks/angular-mocks.js',
      'dist/libs/angular-sanitize/angular-sanitize.min.js',
      'dist/scripts/**/*.js',
      'dist/scripts/*.js',
      'spec/**/*.js'
    ]


# ==================================
# Vendors
# ==================================

# Check git installation
# ======================
gitCheck = (done) ->
  unless shellPlugin.which 'git'
    gutil.log("""
      #{gutil.colors.red('Git is not installed.')}
      \n Git, the version control system, is required to download dependencies."""
    )
    process.exit 1
  done()


# Install Bower Components
# ======================
install = ->
  unless shellPlugin.which('bower')
    gutil.log gutil.colors.red '=== BOWER IS NOT INSTALLED === ..Abort!!'
    process.exit 1

  bower.commands.prune()
    .on 'log', (data) ->
      gutil.log '[Bower Prune]', gutil.colors.cyan data.id, data.message

  bower.commands.install()
    .on 'log', (data) ->
      gutil.log '[Bower Install]', gutil.colors.cyan data.id, data.message


# ==================================
# Vendors
# ==================================

# Build CSS
# ======================
buildVendorsStyles = ->
  gulp.src [vendors.css.sourceFiles, dist.vendorsCssFile]
    .pipe concatPlugin('vendors')
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: 'vendors', extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory

# Build SASS
# ======================
buildVendorsSASS = ->
 gulp.src vendors.sass.mainSassFile
    .pipe sassPlugin()
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: 'vendors', extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory

# Build Scripts
# ======================
buildVendorsScripts = ->
  gulp.src vendors.scripts
    .pipe gulp.dest(dist.libsDirectory)

  gulp.src bowerDirectory
    .pipe gulp.dest(dist.libsDirectory)


# ==================================
# Source
# ==================================

# Build SASS
# ======================
buildAppStyles = () ->
  gulp.src source.sass.mainSassFile
    .pipe plumberPlugin()
    .pipe sassPlugin()
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: "#{projectName.fileName}", extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory

# Build CoffeeScript
# ======================
buildAppScripts = () ->
  gulp.src source.coffee.sourceFiles
    .pipe plumberPlugin()
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest dist.jsDirectory

# Build HTML
# ======================
buildMarkup = ->
  gulp.src(source.html.sourceFiles)
    .pipe gulp.dest(dist.htmlDirectory)

# Copy Resources
# ======================
copyResourcesToDistFolder = ->
  gulp.src(source.resourcesFiles)
    .pipe gulp.dest(dist.resourcesDirectory)

# Copy Images to Dist
# ======================
copyImgToDistFolder = ->
  gulp.src(source.img.sourceFiles)
    .pipe gulp.dest(dist.imgDirectory)

# Copy index.html
# ======================
copyIndexToDistFolder = ->
  gulp.src(source.indexFile)
    .pipe gulp.dest(dist.directory)
    .on 'end', includeSources

# Include Sources from a list
# ======================
includeSources = ->
  gulp.src dist.indexFile
    .pipe includeSourcesPlugin({ cwd: dist.directory })
    .pipe gulp.dest(dist.directory)
    .on 'end', ->
      replaceIndexHTMLEnvVariables(envDevVariables, buildMode.dev)


# ==================================
# Watch files
# ==================================
watch = ->
  watchPlugin(name: '[SassWatcher]', glob: source.sass.sourceFiles, buildAppStyles)

  watchPlugin(name: '[CoffeeWatcher]', glob: source.coffee.sourceFiles, ->
    buildAppScripts()
      .on 'end', -> replaceJSEnvVariables(envDevVariables, buildMode.dev)
  )

  watchPlugin(name: '[HtmlWatcher]', glob: source.html.sourceFiles, buildMarkup)

  watchPlugin(name: '[IndexFileWatcher]', glob: source.indexFile, copyIndexToDistFolder)

  watchPlugin(name: '[CopyImgToDistFolder]', glob: source.img.sourceFiles, copyImgToDistFolder)

  watchPlugin(name: '[CopyResourcesToDistFolder]', glob: source.resourcesFiles, copyResourcesToDistFolder)


# ==================================
# Distribuition
# ==================================

# Clean Dist Directories
# ======================
cleanDist = ->
  gulp.src(dist.directory)
    .pipe cleanPlugin(force: yes)

cleanDistScriptsDirectory = ->
  gulp.src(dist.jsDirectory)
    .pipe cleanPlugin(force: yes)

# Clean Release Directories
# ======================
cleanRelease = ->
  gulp.src(release.directory)
    .pipe cleanPlugin(force: yes)

# ==================================
# Release
# ==================================

# Build index.html
# ======================
proccessIndexFile = ->
  gulp.src(dist.indexFile)
    .pipe(
      useminPlugin(
        js: [
          uglifyPlugin()
        ]
      )
    )
    .pipe(gulp.dest(release.directory))

# Copy Markup
# ======================
copyMarkupToReleaseFolder = ->
  gulp.src(dist.htmlFiles)
    .pipe gulp.dest(release.htmlDirectory)

# Minify Markup
# ======================
minifyMarkupInReleaseFolder = ->
  gulp.src(release.htmlFiles)
    .pipe(htmlMinPlugin(quotes: true, empty: true, spare: true))
    .pipe(gulp.dest(release.htmlDirectory))

  gulp.src(release.indexFile)
    .pipe(htmlMinPlugin(quotes: true, empty: true, spare: true))
    .pipe(gulp.dest(release.directory))

# Copy CSS
# ======================
copyCssToReleaseFolder = ->
  gulp.src(dist.cssFiles)
    .pipe gulp.dest(release.cssDirectory)

# Copy Img
# ======================
copyImgToReleaseFolder = ->
  gulp.src(dist.imgFiles)
    .pipe gulp.dest(release.imgDirectory)

# Optimize Img
# ======================
optimizeImgInReleaseFolder = ->
  gulp.src(release.imgFiles)
    .pipe(minifyImagesPlugin())
    .pipe gulp.dest(release.imgDirectory)

# Copy Resources
# ======================
copyResourcesToReleaseFolder = ->
  gulp.src(dist.resourcesFiles.fonts)
    .pipe gulp.dest(release.resourcesDirectory.fonts)

  gulp.src(dist.resourcesFiles.flex)
    .pipe gulp.dest(release.resourcesDirectory.flex)

  gulp.src(dist.resourcesFiles.videos)
    .pipe gulp.dest(release.resourcesDirectory.videos)

# Obfuscate Javascript
# ======================
ofuscateJSFiles = ->
  gulp.src release.jsFiles
    .pipe obfuscatePlugin(
      exclude       : ['angular', '_', '$', 'jQuery', 'videojs', '_V_', 'FB', '$injector']
    )
    .pipe gulp.dest(release.jsDirectory)

# Replace JS Env variables
# ======================
replaceJSEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then dist.jsDirectory else release.jsDirectory
  sourceFiles   = if modeName is buildMode.dev then dist.jsFiles     else release.jsFiles

  gulp.src sourceFiles
    .pipe regexReplacePlugin(
      regex: envVariableFormat.preTextSalt + 'APP_CURRENT_IP' + envVariableFormat.posTextSalt
      replace: envVariablesMap.APP_CURRENT_IP
    )
    .on 'end' , -> gutil.log "[replace JS #{modeName} Variables]", gutil.colors.cyan 'done!'
    .pipe gulp.dest( destDirectory )

# Replace HTML Env variables
# ======================
replaceHTMLEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then dist.htmlDirectory else release.htmlDirectory
  sourceFiles   = if modeName is buildMode.dev then dist.htmlFiles     else release.htmlFiles

# Replace Index HTML Env variables
# ======================
replaceIndexHTMLEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then dist.directory else release.directory
  sourceFiles   = if modeName is buildMode.dev then dist.indexFile else release.indexFile

  gulp.src sourceFiles
    .pipe regexReplacePlugin(
      regex: envVariableFormat.preTextSalt + 'APP_ANALYTICS' + envVariableFormat.posTextSalt
      replace: envVariablesMap.APP_ANALYTICS
    )
    .on 'end' , ->
      gutil.log "[replace Index HTML #{modeName} Variables]", gutil.colors.cyan 'done!'
    .pipe gulp.dest( destDirectory )


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

# Dist tasks
# =======================
gulp.task 'cleanDist'                    , [                           ], cleanDist
gulp.task 'gitCheck'                     , ['cleanDist'                ], gitCheck
gulp.task 'install'                      , ['gitCheck'                 ], install
gulp.task 'buildVendorsSASS'             , ['install'                  ], buildVendorsSASS
gulp.task 'buildVendorsStyles'           , ['buildVendorsSASS'         ], buildVendorsStyles
gulp.task 'buildVendorsScripts'          , ['install'                  ], buildVendorsScripts
gulp.task 'buildAppStyles'               , ['cleanDist'                ], buildAppStyles
gulp.task 'buildAppScripts'              , ['cleanDist'                ], buildAppScripts
gulp.task 'buildMarkup'                  , ['cleanDist'                ], buildMarkup
gulp.task 'copyResourcesToDistFolder'    , ['cleanDist'                ], copyResourcesToDistFolder
gulp.task 'copyImgToDistFolder'          , ['cleanDist'                ], copyImgToDistFolder
gulp.task 'copyIndexToDistFolder'        , ['copyResourcesToDistFolder'], copyIndexToDistFolder
gulp.task 'replaceJSDevVariables'        , ['default'                  ], -> replaceJSEnvVariables(envDevVariables, buildMode.dev)
gulp.task 'replaceHTMLDevVariables'      , ['default'                  ], -> replaceHTMLEnvVariables(envDevVariables, buildMode.dev)
gulp.task 'replaceIndexHTMLDevVariables' , ['default'                  ], -> replaceIndexHTMLEnvVariables(envDevVariables, buildMode.dev)

gulp.task 'default', [
  'cleanDist'
  'gitCheck'
  'install'
  'buildVendorsSASS'
  'buildVendorsStyles'
  'buildVendorsScripts'
  'buildAppStyles'
  'buildAppScripts'
  'buildMarkup'
  'copyResourcesToDistFolder'
  'copyImgToDistFolder'
  'copyIndexToDistFolder'
]

# Dev tasks
# =======================
gulp.task 'watch'     , ['default'], watch
gulp.task 'dev'       , ['watch', 'replaceJSDevVariables', 'replaceHTMLDevVariables', 'replaceIndexHTMLDevVariables']
gulp.task 'buildDev'  , ['default', 'replaceJSDevVariables', 'replaceHTMLDevVariables', 'replaceIndexHTMLDevVariables']

# Release tasks
# =======================
gulp.task 'cleanRelease'                  , ['default'                  ], cleanRelease
gulp.task 'proccessIndexFile'             , ['cleanRelease'             ], proccessIndexFile
gulp.task 'copyMarkupToReleaseFolder'     , ['proccessIndexFile'        ], copyMarkupToReleaseFolder
gulp.task 'minifyMarkupInReleaseFolder'   , ['copyMarkupToReleaseFolder'], minifyMarkupInReleaseFolder
gulp.task 'copyCssToReleaseFolder'        , ['cleanRelease'             ], copyCssToReleaseFolder
gulp.task 'copyImgToReleaseFolder'        , ['cleanRelease'             ], copyImgToReleaseFolder
gulp.task 'optimizeImgInReleaseFolder'    , ['copyImgToReleaseFolder'   ], optimizeImgInReleaseFolder
gulp.task 'copyResourcesToReleaseFolder'  , ['cleanRelease'             ], copyResourcesToReleaseFolder
gulp.task 'ofuscateJSFiles'               , ['proccessIndexFile'        ], ofuscateJSFiles
gulp.task 'replaceJSProdVariables'        , ['build'                    ], -> replaceJSEnvVariables(envProdVariables, buildMode.prod)
gulp.task 'replaceHTMLProdVariables'      , ['build'                    ], -> replaceHTMLEnvVariables(envProdVariables, buildMode.prod)
gulp.task 'replaceIndexHTMLProdVariables' , ['build'                    ], -> replaceIndexHTMLEnvVariables(envProdVariables, buildMode.prod)

gulp.task 'build', [
  'cleanRelease'
  'proccessIndexFile'
  'copyMarkupToReleaseFolder'
  'minifyMarkupInReleaseFolder'
  'copyCssToReleaseFolder'
  'copyImgToReleaseFolder'
  'optimizeImgInReleaseFolder'
  'copyResourcesToReleaseFolder'
]

gulp.task 'release', [ 'build', 'replaceJSProdVariables', 'replaceHTMLProdVariables', 'replaceIndexHTMLProdVariables']

# Test tasks
# =======================
gulp.task 'test'          , ['buildSpecScripts', 'runAppTests']
gulp.task 'testAndWatch'  , ['test', 'watchSpecs']