# Generated on 2014-03-28 using generator-phaser-official 0.0.8-rc-2
"use strict"

config  = require("./config.json")
_       = require("underscore")
_.str   = require("underscore.string")

# Mix in non-conflict functions to Underscore namespace if you want
_.mixin _.str.exports()
LIVERELOAD_PORT = 35729
lrSnippet       = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder     = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  
  # ==========================
  # Load all grunt tasks
  # ==========================
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  # ==========================
  # Configuration of tasks
  # ==========================
  grunt.initConfig
    
    ## Notifications
    # ==========================
    notify:
      coffeelinter :
        options:
          title   : 'Coffeelinter'
          message : 'Coffeelinter has finished!'

    ## Watch files
    # ==========================
    watch:
      coffee:
        files   : 'source/**/*.coffee'
        tasks   : [ 'build' ]
        options :
          livereload: LIVERELOAD_PORT

      scripts:
        files: [
          "game/**/*.js"
          "!game/main.js"
        ]
        options:
          spawn: false
          livereload: LIVERELOAD_PORT
        tasks: ["build"]

      
    ## Compile coffeeScript
    # ==========================  
    coffee:
      buildAppScripts:
        expand  : yes
        flatten : no
        bare    : yes
        cwd     : 'source'
        src     : ['**/*.coffee']
        dest    : 'game'
        ext     : '.js'

    ## Validate Good Pratices
    # ==========================  
    coffeelinter:
      target  : ['source/app/scripts/**/*.coffee']
      tasks   : ['notify:coffeelinter']
      options :
        force         : no
        reportConsole : yes

              ### Ignore ###
        # ========================== 
        "no_trailing_whitespace":
          level: "ignore"
        "max_line_length" :
          level: "ignore"
        "min_line_length" :
          level: "ignore"
        "no_unnecessary_fat_arrows" :
          level: "ignore"
        "indentation" :
          level: "ignore"

    ## Localhost server
    # ==========================
    connect:
      options:
        port: 9000
        
        # change this to '0.0.0.0' to access the server from outside
        hostname: "0.0.0.0"

      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, "dist")
            ]

    ## Open browser on server up
    # ==========================
    open:
      server:
        path: "http://localhost:9000"

    ## Copy files
    # ==========================
    copy:
      dist:
        files: [
          {
            # includes files within path and its sub-directories
            expand: true
            src: ["assets/**"]
            dest: "dist/"
          }
          {
            expand: true
            flatten: true
            src: ["game/plugins/*.js"]
            dest: "dist/js/plugins/"
          }
          {
            expand: true
            flatten: true
            src: ["bower_components/**/build/*.js"]
            dest: "dist/js/"
          }
          {
            expand: true
            src: ["css/**"]
            dest: "dist/"
          }
          {
            expand: true
            src: ["index.html"]
            dest: "dist/"
          }
        ]

    browserify:
      build:
        src: ["game/game.js"]
        dest: "dist/js/game.js"


  # ==========================
  # Register tasks
  # ==========================
  grunt.registerTask "build", [
    "coffeelinter"
    "coffee"
    "buildBootstrapper"
    "browserify"
    "copy"
  ]
  grunt.registerTask "serve", [
    "build"
    "connect:livereload"
    "open"
    "watch"
  ]
  grunt.registerTask "default", ["serve"]
  grunt.registerTask "prod", [
    "build"
    "copy"
  ]

  # ==========================
  # Additional Tasks
  # ==========================
  grunt.registerTask "buildBootstrapper", "builds the bootstrapper file correctly", ->
    stateFiles = grunt.file.expand("game/states/*.js")
    gameStates = []
    statePattern = new RegExp(/([^\/]+).js$/)
    stateFiles.forEach (file) ->
      state = file.match(statePattern)[1]
      unless not state
        gameStates.push
          shortName: state
          stateName: _.capitalize(state) + "State"

      return

    config.gameStates = gameStates
    console.log config
    bootstrapper = grunt.file.read("templates/_main.js.tpl")
    bootstrapper = grunt.template.process(bootstrapper,
      data: config
    )
    grunt.file.write "game/game.js", bootstrapper
    return

  return