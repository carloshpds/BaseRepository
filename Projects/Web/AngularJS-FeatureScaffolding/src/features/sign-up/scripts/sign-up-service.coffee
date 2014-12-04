'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.services'
  
  # =============================================
  # SignUpService
  # =============================================
  .service 'SignUpService', ['$http', 'SG_BASE_URL', ($http, SG_BASE_URL) ->
    signUp: (params) ->
      $http
        url         : SG_BASE_URL + 'signUp'
        method      : 'POST'
        params      : params
  ]