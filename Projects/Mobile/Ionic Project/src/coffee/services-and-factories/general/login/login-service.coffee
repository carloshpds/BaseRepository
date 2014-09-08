'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # LoginService
  # =============================================
  .service 'LoginService', ['$http', 'PROJECT_BASE_URL', ($http, PROJECT_BASE_URL) ->
    
    login: (data) ->
      $http
        url         : PROJECT_BASE_URL + 'login/authenticate'
        method      : 'POST'
        data        : data
        nointercept : yes
        headers     :
          "Content-type": "application/x-www-form-urlencoded"

    loginWithFacebook: (data) ->
      $http
        url         : PROJECT_BASE_URL + 'login/authenticate'
        method      : 'POST'
        data        : data
        nointercept : yes
        headers     :
          "Content-type": "application/x-www-form-urlencoded"

    loggout: ->
      $http
        url         : PROJECT_BASE_URL + 'login/logout'
        method      : 'POST'
        nointercept : yes
        headers     :
          "Content-type": "application/x-www-form-urlencoded"
      
  ]
