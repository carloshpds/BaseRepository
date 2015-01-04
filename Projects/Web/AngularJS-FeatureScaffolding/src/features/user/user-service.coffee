'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.services'
  
  # =============================================
  # UserService
  # =============================================
  .service 'UserService', ['$http', 'APP_BASE_URL', ($http, APP_BASE_URL) ->
    
    getLoggedUserInfo: (data) ->
      $http
        url           : APP_BASE_URL + 'user/info'
        method        : 'GET'
        nointercept   : yes
  ]
