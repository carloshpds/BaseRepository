'use strict'


angular.module 'IonicProjectModelApp', ['ionic', 'ui.router', 'ngSanitize', 'ngAnimate', 'QuickList', 'ngCordova']


  # =============================================
  # Initialize
  # =============================================
  .run([ '$ionicPlatform', '$injector', '$cordovaGA', ($ionicPlatform, $injector, $cordovaGA) ->

    # Default style to statusBar
    # =================================
    $ionicPlatform.ready ->
      #Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      #for form inputs)
      if window.cordova
        if window.cordova.plugins.Keyboard
          cordova.plugins.Keyboard.hideKeyboardAccessoryBar true
          # cordova.plugins.Keyboard.disableScroll(true)

        ionic.Platform.isFullScreen = true
        StatusBar.styleDefault() if window.StatusBar

        # Initialize Google Analytics
        # =============================================
        $cordovaGA.init 'UA-XXXXX' # Change XXXXX to your site's ID

    # Import underscore-string to underscore
    # =================================
    _.mixin(_.string.exports())

    # Change Moment relative time
    moment.lang 'pt-br',
      relativeTime :
        future: "em %s"
        past:   "%s atrás"
        s:  "segundos"
        m:  "um minuto"
        mm: "%d minutos"
        h:  "uma hora"
        hh: "%d horas"
        d:  "um dia"
        dd: "%d dias"
        M:  "um mês"
        MM: "%d meses"
        y:  "um ano"
        yy: "%d anos"

    moment.lang('pt-br')

    $injector.invoke ['$rootScope', 'PROJECT_CURRENT_DEVICE_OS', ($rootScope, PROJECT_CURRENT_DEVICE_OS) ->
      $rootScope.currentOS = PROJECT_CURRENT_DEVICE_OS
    ]


  ])

  # =============================================
  # httpProvider Config
  # =============================================
  .config( ['$httpProvider', ($httpProvider) ->

    # Customize $httpProvider
    # =============================================
    # $httpProvider.defaults.transformRequest  = (data) -> if data then $.param(data) else data
    
  ])

  
