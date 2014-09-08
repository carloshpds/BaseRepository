'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # App Config
  # =============================================
  .config( ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    # States
    # =============================================
    $stateProvider

      # General
      # ==============================
      .state('sign-up'
        url         : '/sign-up'
        templateUrl : 'views/general/sign-up/sign-up.html'
        controller  : 'SignUpController'
      )

      .state('login'
        url         : '/login'
        templateUrl : 'views/general/login/login.html'
        controller  : 'LoginController'
      )


    # Default State
    # =============================================
    $urlRouterProvider.otherwise('/login')
  ])
