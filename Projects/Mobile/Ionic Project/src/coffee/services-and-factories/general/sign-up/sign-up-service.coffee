'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # SignUpService
  # =============================================
  .service 'SignUpService', ['$http', 'PROJECT_BASE_URL', ($http, PROJECT_BASE_URL) ->
    signUp: (params) ->
      $http
        url         : PROJECT_BASE_URL + 'user'
        method      : 'POST'
        params      : params
        nointercept : yes
  ]