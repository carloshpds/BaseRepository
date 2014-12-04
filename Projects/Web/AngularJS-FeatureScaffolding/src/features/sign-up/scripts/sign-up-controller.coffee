'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.controllers'

  # =============================================
  # SignUpController
  # =============================================
  .controller 'SignUpController',
    ['$scope', 'SignUpService', '$state', 'MessagesEnumsFactory',
    ($scope, SignUpService, $state, MessagesEnumsFactor) ->

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
      $scope.error =
        username            : false
        userPassword        : false
        userConfirmPassword : false
        userEmail           : false
      

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
        return username is null or username.length < 2

      @validatePassword = (userPassword) ->
        return userPassword is null or userPassword.length < 6

      @validateConfirmPassword = (userPassword, userConfirmPassword) ->
        return userConfirmPassword is null or userConfirmPassword isnt userPassword

      @validateEmail = (userEmail) ->
        return userEmail is null or userEmail.length < 6

      # =============================================
      # Handlers
      # =============================================
      @clickSignUpButtonHandler = () ->
        user = angular.copy($scope.user)
        delete user.confirmPassword

        promise = SignUpService.signUp user
        promise.success (data, status) -> $state.go 'login'
        promise.error   (data) ->
          message = MessagesEnumsFactory.get(data.message)

      # =============================================
      # Methods
      # =============================================
      $scope.goState = (state) -> $state.go state

  ]