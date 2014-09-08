'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'

  # =============================================
  # SignUpController
  # =============================================
  .controller 'SignUpController',
    ['$scope', 'SignUpService', '$state', 'MessagesEnumsFactory', '$ionicLoading',
    ($scope, SignUpService, $state, MessagesEnumsFactory, $ionicLoading) ->

      # =============================================
      # Atributes
      # =============================================
      $scope.user =
        username        : null
        password        : null
        confirmPassword : null
        email           : null

      # =============================================
      # Validation
      # =============================================
      $scope.error = {
        username            : false
        userPassword        : false
        userConfirmPassword : false
        userEmail           : false
      }

      $scope.hasError = true

      $scope.validInput = (user) =>
        @validateName            user.username
        @validatePassword        user.password
        @validateConfirmPassword user.password, user.confirmPassword
        @validateEmail           user.email

        lastPropValue = undefined
        for prop, propValue of $scope.error
          if lastPropValue is undefined
            lastPropValue = propValue
            continue

          r = lastPropValue | propValue
          lastPropValue = propValue if lastPropValue isnt true and propValue is true

        $scope.hasError = false if lastPropValue is false

        @clickSignUpButtonHandler() if $scope.hasError is false


      @validateName = (username) ->
        if username is null or username.length < 2
          $scope.error.username = true
        else
          $scope.error.username = false

      @validatePassword = (userPassword) ->
        if userPassword is null or userPassword.length < 6
          $scope.error.userPassword = true
        else
          $scope.error.userPassword = false

      @validateConfirmPassword = (userPassword, userConfirmPassword) ->
        if userConfirmPassword is null or userConfirmPassword isnt userPassword
          $scope.error.userConfirmPassword = true
        else
          $scope.error.userConfirmPassword = false

      @validateEmail = (userEmail) ->
        if userEmail is null or userEmail.length < 6
          $scope.error.userEmail = true
        else
          $scope.error.userEmail = false

      # =============================================
      # Handlers
      # =============================================
      @clickSignUpButtonHandler = () ->

        user = angular.copy($scope.user)
        delete user.confirmPassword

        $ionicLoading.show()
        promise = SignUpService.signUp user
        promise.success (data, status) -> $state.go 'login'
        promise.error   (data) ->
          message = MessagesEnumsFactory.get(data.message)
          NotificationsFactory.add message
        promise.finally ->
          $ionicLoading.hide()

      # =============================================
      # Methods
      # =============================================
      $scope.goState = (state) -> $state.go state

  ]