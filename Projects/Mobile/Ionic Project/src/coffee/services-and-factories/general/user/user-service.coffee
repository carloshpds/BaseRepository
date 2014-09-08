'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # UserService
  # =============================================
  .service 'UserService', ['$http', 'PROJECT_BASE_URL', ($http, PROJECT_BASE_URL) ->
    
    getLoggedUserInfo: (data) ->
      $http
        url           : PROJECT_BASE_URL + 'user/info'
        method        : 'GET'
        nointercept   : yes
  ]
