'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.services'
  
  # =============================================
  # SignUpService
  # =============================================
  .service 'SignUpService', ['$http', 'APP_BASE_URL', ($http, APP_BASE_URL) ->
    signUp: (params) ->
      $http
        url         : APP_BASE_URL + 'signUp'
        method      : 'POST'
        params      : params
  ]