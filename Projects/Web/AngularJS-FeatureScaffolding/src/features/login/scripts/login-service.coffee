'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.services'
  
  # =============================================
  # LoginService
  # =============================================
  .service 'LoginService', ['$http', 'SG_BASE_URL', ($http, SG_BASE_URL) ->
    
    return {
      
      login: (data) ->
        $http
          url         : SG_BASE_URL + 'login'
          method      : 'POST'
          data        : data

      loginWithFacebook: (data) ->
         $http
          url         : SG_BASE_URL + 'login'
          method      : 'POST'
          data        : data

      signUp: (data) ->
        $http
          url         : SG_BASE_URL + 'email-fila'
          method      : 'POST'
          data        : data 

      loggout: ->
        $http
          url         : SG_BASE_URL + 'login/loggout'
          method      : 'POST'
    }
      
  ]
