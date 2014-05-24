
# ==================================
# Imports
# ==================================
gulp          = require 'gulp'
gutil         = require 'gulp-util'
bower         = require 'bower'
concat        = require 'gulp-concat'
sassPlugin    = require 'gulp-ruby-sass'
minifyCss     = require 'gulp-minify-css'
rename        = require 'gulp-rename'
sh            = require 'shelljs'
coffeePlugin  = require 'gulp-coffee'
watch         = require 'gulp-watch'
gif           = require 'gulp-if'
cleanPlugin   = require 'gulp-clean'




# ==================================
# Path Variables
# ==================================

vendors =
  sass:
    sourceFiles : './vendors/styles/**/*.{sass, scss}'
    mainSassFile: './vendors/styles/vendors.sass'

source = 
  coffee:
    sourceFiles : ['./src/coffee/**/*.coffee']
  sass:
    sourceFiles : 'src/styles/**/*.{sass, scss}'
    mainSassFile: 'src/styles/slot-lunch.sass'
  html:
    sourceFiles : 'src/views/**/*.html'

dist =
  directory     : './www'
  jsDirectory   : './www/js/'
  cssDirectory  : './www/css/'
  htmlDirectory : './www/html'


# ==================================
# Vendors
# ==================================

# Build SASS
# ======================
gulp.task 'sass-vendors', ->
  gulp.src vendors.sass.mainSassFile
    .pipe sassPlugin()
    .pipe minifyCss keepSpecialComments: 0
    .pipe rename basename: 'vendors', extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory


# Install Bower Components
# ======================
gulp.task 'install', ['git-check'], ->
  bower.commands.install()
    .on 'log', (data) ->
      gutil.log 'bower', gutil.colors.cyan data.id, data.message


# Check git installation
# ======================
gulp.task 'git-check', (done) ->
  if sh.which 'git'
    console.log(
      '  ' + gutil.colors.red 'Git is not installed.',
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan 'http://git-scm.com/downloads' + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan 'gulp install' + '\' again.'
    )
    process.exit 1
  done()

# ==================================
# Src
# ==================================              

# Watch Files
# ======================
gulp.task 'watch', ['clean-dist', 'buildAppStyles', 'buildAppScripts', 'buildMarkup'], ->
  gulp.watch source.sass.sourceFiles      , ['buildAppStyles']
  gulp.watch source.coffee.sourceFiles    , ['buildAppScripts']
  gulp.watch source.html.sourceFiles      , ['buildMarkup']


# Build SASS
# ======================
gulp.task 'buildAppStyles', ['clean-dist'], ->
  gulp.src source.sass.mainSassFile
    .pipe sassPlugin()
    .pipe minifyCss keepSpecialComments: 0
    .pipe rename basename: 'slot-lunch', extname: '.min.css'
    .pipe gulp.dest dist.cssDirectory


# Build CoffeeScript
# ======================
gulp.task 'buildAppScripts', ['clean-dist'], ->
  gulp.src source.coffee.sourceFiles
    .pipe coffeePlugin bare: yes
    .on 'error', gutil.log
    .pipe gulp.dest dist.jsDirectory


# Build HTML
# ======================    
gulp.task 'buildMarkup', ->
  gulp.src(source.html.sourceFiles)
    .pipe gulp.dest(dist.htmlDirectory)


# ==================================
# Distribuition
# ==================================  

# Clean Dist Directories
# ======================
gulp.task 'clean-dist', ->

  gulp.src(dist.cssDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.jsDirectory)
    .pipe cleanPlugin(force: yes)

  gulp.src(dist.htmlDirectory)
    .pipe cleanPlugin(force: yes)


# ==================================
# Register Macro Tasks
# ==================================
gulp.task 'default', ['clean-dist', 'buildAppStyles', 'buildAppScripts', 'buildMarkup', 'watch']
gulp.task 'build'  , ['clean-dist', 'buildAppStyles', 'buildAppScripts', 'buildMarkup']
