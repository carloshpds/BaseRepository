'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.services'
  
  # =============================================
  # UserService
  # =============================================
  .service 'UserService', ['$http', 'SG_BASE_URL', ($http, SG_BASE_URL) ->
    
    getLoggedUserInfo: (data) ->
      $http
        url           : SG_BASE_URL + 'user/info'
        method        : 'GET'
        nointercept   : yes
  ]
