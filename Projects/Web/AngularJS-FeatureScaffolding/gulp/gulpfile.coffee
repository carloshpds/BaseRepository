
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
  fileName     : 'my-angular-omakase'
  officialName : 'MyAngularOmakase'

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
  SG_CURRENT_IP     : 'localhost:8080'
  SG_ANALYTICS      : ''
  SG_ADMIN_BASE_URL : ''

# Server Test Variables
# ======================
envServerTestVariables =
  SG_CURRENT_IP     : 'localhost:8080'
  SG_ANALYTICS      : ''
  SG_ADMIN_BASE_URL : ''

# Prod Variables
# ======================
envProdVariables =
  SG_CURRENT_IP     : 'localhost:8080'
  SG_ANALYTICS      : ''
  SG_ADMIN_BASE_URL : ''

# ==================================
# Path Variables
# ==================================

bowerDirectory = 'bower_components/**/*'

paths =
  vendors :
    scripts      : 'vendors/scripts/**/*.js'
    sass:
      sourceFiles : 'vendors/styles/**/*.{sass, scss}'
      mainSassFile: 'vendors/styles/vendors.sass'
    css :
      sourceFiles : 'vendors/styles/**/*.css'


  source :
    coffee:
      sourceFiles : ['src/**/*.coffee']
    sass:
      sourceFiles : 'src/**/*.{sass, scss}'
      mainSassFile: "src/main/styles/app.sass"
    html:
      sourceFiles : 'src/**/*.html'
    img:
      sourceFiles : 'src/main/img/**/*.{jpeg, jpg, png}'
    resourcesFiles: 'src/main/resources/**/*'
    indexFile: 'src/main/index.html'



  dev :
    directory          : 'dev/'
    jsDirectory        : 'dev/scripts/'
    cssDirectory       : 'dev/styles/'
    htmlDirectory      : 'dev/views/'
    imgDirectory       : 'dev/img/'
    indexFile          : 'dev/index.html'
    libsDirectory      : 'dev/libs/'
    resourcesDirectory : 'dev/resources/'
    resourcesFiles     :
      fonts  : 'dev/resources/fonts/**/*'
      videos : 'dev/resources/videos/**/*'
    files              : ['dev/scripts/**/*', 'dev/styles/**/*', 'dev/views/**/*', 'dev/img/**/*', 'dev/index.html']
    vendorsCssFile     : 'dev/styles/vendors.min.css'
    jsFiles            : 'dev/scripts/**/*'
    cssFiles           : 'dev/styles/**/*'
    htmlFiles          : 'dev/views/**/*'
    imgFiles           : 'dev/img/**/*'

  release :
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
      videos : 'release/resources/videos/'
    resourcesFiles  :
      fonts  : 'release/resources/fonts/**/*'
      videos : 'release/resources/videos/**/*'

  spec :
    coffee:
      sourceFiles : ['spec/coffee/**/*.coffee']
    js:
      directory   : 'spec/js'
      sourceFiles : [
        'dev/libs/jquery/jquery.js',
        'dev/libs/angular/angular.js',
        'dev/libs/underscore/underscore.js',
        'dev/libs/angular-ui-router/release/angular-ui-router.js',
        'dev/libs/angular-mocks/angular-mocks.js',
        'dev/libs/angular-sanitize/angular-sanitize.js',
        'dev/libs/angular-bootstrap/ui-bootstrap-tpls.js',
        'dev/libs/underscore-string.js',
        'dev/libs/momentjs/min/moment-with-langs.js',
        'dev/libs/quick-ng-repeat/quick-ng-repeat.js',
        'dev/scripts/main/scripts/app.js',
        'dev/scripts/components/**/*.js',
        'dev/scripts/features/**/*.js',
        'dev/scripts/main/scripts/config/**/*.js',
        'dev/scripts/main/scripts/constants/**/*.js',
        'dev/scripts/main/scripts/runners/**/*.js',
        'dev/views/**/*.html',
        'spec/js/**/*.js'
        'spec/utils/**/*.js'
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


# Build SASS
# ======================
buildVendorsSASS = ->
 # gulp.src paths.vendors.sass.mainSassFile
 #    .pipe sassPlugin()
 #    .pipe minifyCssPlugin keepSpecialComments: 0
 #    .pipe rename basename: 'vendors', extname: '.min.css'
 #    .pipe gulp.dest paths.dev.cssDirectory

# Build CSS
# ======================
buildVendorsStyles = ->
  gulp.src [paths.vendors.css.sourceFiles, paths.dev.vendorsCssFile]
    .pipe concatPlugin('vendors')
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: 'vendors', extname: '.min.css'
    .pipe gulp.dest paths.dev.cssDirectory


buildVendorsScripts = ->
  gulp.src paths.vendors.scripts
    .pipe gulp.dest(paths.dev.libsDirectory)

  gulp.src bowerDirectory
    .pipe gulp.dest(paths.dev.libsDirectory)

# ==================================
# Source
# ==================================

# Build SASS
# ======================
buildAppStyles = () ->
  gulp.src paths.source.sass.mainSassFile
    .pipe plumberPlugin()
    .pipe sassPlugin()
    .pipe minifyCssPlugin keepSpecialComments: 0
    .pipe rename basename: "app", extname: '.min.css'
    .pipe gulp.dest paths.dev.cssDirectory

# Build CoffeeScript
# ======================
buildAppScripts = () ->
  gulp.src paths.source.coffee.sourceFiles
    .pipe plumberPlugin()
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest paths.dev.jsDirectory

# Build HTML
# ======================
buildMarkup = ->
  gulp.src(paths.source.html.sourceFiles)
    .pipe gulp.dest(paths.dev.htmlDirectory)

# Copy Resources
# ======================
copyResourcesToDistFolder = ->
  gulp.src(paths.source.resourcesFiles)
    .pipe gulp.dest(paths.dev.resourcesDirectory)

# Copy Images to Dist
# ======================
copyImgToDistFolder = ->
  gulp.src(paths.source.img.sourceFiles)
    .pipe gulp.dest(paths.dev.imgDirectory)

# Copy index.html
# ======================
copyIndexToDistFolder = ->
  gulp.src(paths.source.indexFile)
    .pipe gulp.dest(paths.dev.directory)
    .on 'end', includeSources

# Include Sources from a list
# ======================
includeSources = ->
  gulp.src paths.dev.indexFile
    .pipe includeSourcesPlugin({ cwd: paths.dev.directory })
    .pipe gulp.dest(paths.dev.directory)
    .on 'end', ->
      replaceIndexHTMLEnvVariables(envDevVariables, buildMode.dev)


# ==================================
# Watch files
# ==================================
watch = ->

  # liveReloadPlugin.listen(LIVE_RELOAD_PORT)
  # gulp.watch(paths.dev.files).on 'change', liveReloadPlugin.changed

  gulp.watch(paths.source.sass.sourceFiles).on('change', (e) ->
    buildAppStyles()
      .on 'end', ->
        gutil.log( gutil.colors.red('[SassWatcher] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )

  gulp.watch(paths.source.coffee.sourceFiles).on('change', (e) ->
    buildAppScripts()
      .on 'end', ->
        replaceJSEnvVariables(envDevVariables, buildMode.dev)
        gutil.log( gutil.colors.red('[CoffeeWatcher] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )

  gulp.watch(paths.source.html.sourceFiles).on('change', (e) ->
    buildMarkup()
      .on 'end', ->
        gutil.log( gutil.colors.red('[HtmlWatcher] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )

  gulp.watch(paths.source.html.sourceFiles).on('change', (e) ->
    copyIndexToDistFolder()
      .on 'end', ->
        gutil.log( gutil.colors.red('[IndexFileWatcher] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )


  gulp.watch(paths.source.img.sourceFiles).on('change', (e) ->
    copyImgToDistFolder()
      .on 'end', ->
        gutil.log( gutil.colors.red('[CopyImgToDistFolder] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )

  gulp.watch(paths.source.resourcesFiles).on('change', (e) ->
    copyResourcesToDistFolder()
      .on 'end', ->
        gutil.log( gutil.colors.red('[CopyResourcesToDistFolder] ') + gutil.colors.magenta( _.last(e.path.split('/')) ) + ' was changed' )
  )

# ==================================
# Distribuition
# ==================================

# Clean Dist Directories
# ======================
cleanDist = ->
  gulp.src(paths.dev.directory)
    .pipe cleanPlugin(force: yes)

cleanDistScriptsDirectory = ->
  gulp.src(paths.dev.jsDirectory)
    .pipe cleanPlugin(force: yes)

# Clean Release Directories
# ======================
cleanRelease = ->
  gulp.src(paths.release.directory)
    .pipe cleanPlugin(force: yes)

# ==================================
# Build
# ==================================

# Build index.html
# ======================
proccessIndexFile = ->
  gulp.src(paths.dev.indexFile)
    .pipe(
      useminPlugin(
        js: [
          uglifyPlugin()
        ]
      )
    )
    .pipe(gulp.dest(paths.release.directory))

# Copy Markup
# ======================
copyMarkupToReleaseFolder = ->
  gulp.src(paths.dev.htmlFiles)
    .pipe gulp.dest(paths.release.htmlDirectory)

# Minify Markup
# ======================
minifyMarkupInReleaseFolder = ->
  gulp.src(paths.release.htmlFiles)
    .pipe(htmlMinPlugin(quotes: true, empty: true, spare: true))
    .pipe(gulp.dest(paths.release.htmlDirectory))

  gulp.src(paths.release.indexFile)
    .pipe(htmlMinPlugin(quotes: true, empty: true, spare: true))
    .pipe(gulp.dest(paths.release.directory))

# Copy CSS
# ======================
copyCssToReleaseFolder = ->
  gulp.src(paths.dev.cssFiles)
    .pipe gulp.dest(paths.release.cssDirectory)

# Copy Img
# ======================
copyImgToReleaseFolder = ->
  gulp.src(paths.dev.imgFiles)
    .pipe gulp.dest(paths.release.imgDirectory)

# Optimize Img
# ======================
optimizeImgInReleaseFolder = ->
  gulp.src(paths.release.imgFiles)
    .pipe(minifyImagesPlugin())
    .pipe gulp.dest(paths.release.imgDirectory)

# Copy Resources
# ======================
copyResourcesToReleaseFolder = ->
  gulp.src(paths.dev.resourcesFiles.fonts)
    .pipe gulp.dest(paths.release.resourcesDirectory.fonts)

  gulp.src(paths.dev.resourcesFiles.videos)
    .pipe gulp.dest(paths.release.resourcesDirectory.videos)


# Ofuscates Javascript
# ======================
ofuscateJSFiles = ->
  gulp.src paths.release.jsFiles
    .pipe obfuscatePlugin(
      exclude       : ['angular', '_', '$', 'jQuery', 'videojs', '_V_', 'FB', '$injector']
    )
    .pipe gulp.dest(paths.release.jsDirectory)

# Replace JS Env variables
# ======================
replaceJSEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then paths.dev.jsDirectory else paths.release.jsDirectory
  sourceFiles   = if modeName is buildMode.dev then paths.dev.jsFiles     else paths.release.jsFiles

  gulp.src sourceFiles
    .pipe regexReplacePlugin(
      regex   : envVariableFormat.preTextSalt + 'SG_CURRENT_IP' + envVariableFormat.posTextSalt
      replace : envVariablesMap.SG_CURRENT_IP
    )
    .pipe regexReplacePlugin(
      regex   : envVariableFormat.preTextSalt + 'SG_ADMIN_BASE_URL' + envVariableFormat.posTextSalt
      replace : envVariablesMap.SG_ADMIN_BASE_URL
    )
    .on 'end' , -> gutil.log "[replace JS #{modeName} Variables]", gutil.colors.cyan 'done!'
    .pipe gulp.dest( destDirectory )

# Replace HTML Env variables
# ======================
replaceHTMLEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then paths.dev.htmlDirectory else paths.release.htmlDirectory
  sourceFiles   = if modeName is buildMode.dev then paths.dev.htmlFiles     else paths.release.htmlFiles

  # gulp.src sourceFiles
  #   .pipe regexReplacePlugin(
  #     regex: envVariableFormat.preTextSalt + 'SG_ANALYTICS' + envVariableFormat.posTextSalt
  #     replace: envVariablesMap.SG_ANALYTICS
  #   )
  #   .on 'end' , ->
  #     gutil.log "[replace HTML #{modeName} Variables]", gutil.colors.cyan 'done!'
  #   .pipe gulp.dest( destDirectory )

# Replace Index HTML Env variables
# ======================
replaceIndexHTMLEnvVariables = (envVariablesMap, modeName) ->
  destDirectory = if modeName is buildMode.dev then paths.dev.directory else paths.release.directory
  sourceFiles   = if modeName is buildMode.dev then paths.dev.indexFile else paths.release.indexFile

  gulp.src sourceFiles
    .pipe regexReplacePlugin(
      regex: envVariableFormat.preTextSalt + 'SG_ANALYTICS' + envVariableFormat.posTextSalt
      replace: envVariablesMap.SG_ANALYTICS
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
  gutil.log "[Build Spec Scripts]", gutil.colors.cyan 'Building...'
  gulp.watch paths.spec.coffee.sourceFiles, ['buildSpecScripts']


# Build CoffeeScript
# ======================
gulp.task 'buildSpecScripts', [], ->
  gulp.src paths.spec.coffee.sourceFiles
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest paths.spec.js.directory


# RunAppTests
# ======================
gulp.task 'runAppTests', ['buildSpecScripts'], () ->
  gulp.src(paths.spec.js.sourceFiles)
    .pipe( karmaPlugin
      configFile: 'karma.conf.js'
      action    : 'watch'
    )
    .on 'error', (err) ->
      console.log 'runAppTests: ' + err



# ==================================
# Register Macro Tasks
# ==================================

# Dev Distribuition tasks
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


# Release Server Test
# =======================
gulp.task 'replaceJSServerTestVariables'        , ['default'                  ], -> replaceJSEnvVariables(envServerTestVariables, buildMode.dev)
gulp.task 'replaceHTMLServerTestVariables'      , ['default'                  ], -> replaceHTMLEnvVariables(envServerTestVariables, buildMode.dev)
gulp.task 'replaceIndexHTMLServerTestVariables' , ['default'                  ], -> replaceIndexHTMLEnvVariables(envServerTestVariables, buildMode.dev)
gulp.task 'buildToServerTest'                   , ['default', 'replaceJSServerTestVariables', 'replaceHTMLServerTestVariables', 'replaceIndexHTMLServerTestVariables']

# Test tasks
# =======================
gulp.task 'test'          , ['buildSpecScripts', 'runAppTests', 'watchSpecs']
# gulp.task 'testAndWatch'  , ['test', 'watchSpecs']


