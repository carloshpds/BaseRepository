'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase'
  
  # =============================================
  # App Config
  # =============================================
  .config( ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    # States
    # =============================================
    $stateProvider


      # Login
      # ==============================
      .state('login'
        url         : '/login'
        templateUrl : 'views/features/login/views/login.html'
        controller  : 'LoginController'
        data        : 
          restrict  : no
      )


    
  ])
