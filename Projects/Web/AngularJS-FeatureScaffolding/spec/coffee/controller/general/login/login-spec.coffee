'use strict'

# =============================================
# LoginController
# =============================================
describe 'Controller: LoginController', ()->

  # =============================================
  # Import modules
  # =============================================
  beforeEach module('ui.router')
  beforeEach module('ui.bootstrap')
  beforeEach module('MyAngularOmakase.scripts')
  beforeEach module('stateMock')

  # =============================================
  # Variables
  # =============================================
  $scope          = null
  LoginController = null

  # =============================================
  # Inject dependencies
  # =============================================
  beforeEach inject ($controller, $rootScope, _LoginService_, _$state_, _$modal_) ->
    $scope          = $rootScope.$new()
    LoginController = $controller 'LoginController',
      LoginService: _LoginService_
      $scope: $scope
      $state: _$state_
      $modal: _$modal_


  # =============================================
  # Tests
  # =============================================
  describe 'clickLoginButtonHandler', ->
    it 'defines scope.user', ()->
      expect($scope.user).toBeDefined()


  describe 'Attributes', ->
    it 'Should define facebookOptions', ->
      expect(LoginController.facebookOptions).toBeDefined()
