'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'

  # =============================================
  # LoginController
  # =============================================
  .controller 'LoginController', ['$scope', '$window', 'LoginService', '$state', 'NotificationsFactory', 'MessagesEnumsFactory', '$cordovaToast', '$ionicLoading',
    ($scope, $window, LoginService, $state, NotificationsFactory, MessagesEnumsFactory, $cordovaToast, $ionicLoading) ->

      # =============================================
      # Attributes
      # =============================================
      $scope.user =
        username : null
        password : null

      # =============================================
      # Handlers
      # =============================================
      $scope.clickLoginButtonHandler = () ->
        $ionicLoading.show()
        promise = LoginService.login($scope.user)
        promise.success (data, status, headers, config) -> alert 'Connected'
        promise.error (data, status, headers, config, statusText) ->
          message = MessagesEnumsFactory.get "user.does.not.exist"
          if $window.cordova
            $cordovaToast.showLongBottom message
          else
            NotificationsFactory.add message
        promise.finally ->
          $ionicLoading.hide()

      # =============================================
      # Methods
      # =============================================
      $scope.goState = (state) -> $state.go state

  ]