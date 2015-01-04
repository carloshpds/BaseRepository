'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.controllers'

  # =============================================
  # LoginController
  # =============================================
  .controller 'LoginController', ['$scope', '$window', 'LoginService', '$state', '$filter', '$modal', '$q',
    ($scope, $window, LoginService, $state, $filter, $modal, $q) ->

      # =============================================
      # Attributes
      # =============================================
      @facebookOptions  = scope : 'email, publish_actions'
      $scope.user       =
        firstName  : null
        email      : null

      $scope.ableToConnectWithFacebook  = yes
      $scope.$state                     = $state
      

      # =============================================
      # Initialize
      # =============================================
     
      # =============================================
      # Handlers
      # =============================================
      $scope.doLoginWithFacebook = () =>
        if $window.FB
          do @checkLoginState
        else
          do $scope.openBadLoginModal

      $scope.openBadLoginModal = ->
        $modal.open 
          windowClass : 'modal modal-theme-plain myo-modal myo-bad-login-modal'
          templateUrl : 'views/general/login/bad-login-modal.html'

      $scope.openSuccessSignUpModal = ->
        $modal.open 
          windowClass : 'modal modal-theme-plain myo-modal myo-success-modal'
          scope       : $scope
          templateUrl : 'views/general/login/success-sign-up-modal.html'

      # =============================================
      # Methods
      # =============================================
      $scope.loginWithFacebook = (response) =>
        dataParams = 
          accessToken           : response.authResponse.accessToken
          aparelhoInteresseId   : $scope.user.aparelhoInteresseId
          modeloUsuarioId       : $scope.user.modeloUsuarioId

        promise = LoginService.loginWithFacebook(dataParams)
        promise.success -> 
          $sgBackdrop.hide()
          $modal.open 
            windowClass : 'modal modal-theme-plain myo-modal'
            template    : """ 
              <div class="row">
                <div class="col-xs-12 col-md-12 text-align-center">
                  <p class="text-align-center myo-font-semibolditalic myo-font-size-24"> Connected on project by facebook! </p>
                </div>
              </div>
            """ 

        promise.error -> 
          $sgBackdrop.hide()
          $scope.ableToConnectWithFacebook  = yes
          $scope.openBadLoginModal()

      $scope.doLogin  = ->
        promise = LoginService.login($scope.user)
        promise.success (data, status, headers, config) -> 
          $modal.open 
            windowClass : 'modal modal-theme-plain myo-modal'
            template    : """ 
              <div class="row">
                <div class="col-xs-12 col-md-12 text-align-center">
                  <p class="text-align-center myo-font-semibolditalic myo-font-size-24"> Connected on project! </p>
                </div>
              </div>
            """

        promise.error (data, status, headers, config, statusText) ->
          $scope.openBadLoginModal()


      $scope.signUp = ->
        promise = LoginService.signUp( firstName: $scope.user.firstName, email: $scope.user.email )
        promise.success (data, status, headers, config) -> $scope.openSuccessSignUpModal()
        promise.error (data, status, headers, config, statusText) -> $scope.openBadLoginModal()

      # =============================================
      # Aux Methods
      # =============================================
      $scope.goState = (state) -> $state.go state

      @loginFB = =>
        $window.FB.login (response) ->
            if response.status is 'connected'
              $scope.loginWithFacebook response
            else
              $scope.$apply -> 
                $scope.ableToConnectWithFacebook = yes
                $sgBackdrop.hide()
          ,
            @facebookOptions

      @statusChangeCallback = (response) =>
        $sgBackdrop.show()
        if response.status is 'connected'
          $scope.loginWithFacebook response 
        else if response.status is 'not_authorized'
          @loginFB()
        else 
          @loginFB()

      @checkLoginState = () ->
        $scope.ableToConnectWithFacebook = no
        $window.FB.getLoginStatus (response) =>
          @statusChangeCallback response
       

      return @

  ]