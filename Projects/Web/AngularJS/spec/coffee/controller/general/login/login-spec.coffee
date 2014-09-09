'use strict'

# =============================================
# LoginController
# =============================================
describe 'Controller: LoginController', ()->

  # =============================================
  # Import modules
  # =============================================
  beforeEach module('SonyGuruWebApp.scripts')
  beforeEach module('ui.router')

  # =============================================
  # Variables
  # =============================================
  $scope          = null
  LoginController = null

  # =============================================
  # Inject dependencies
  # =============================================
  beforeEach inject ($controller, $rootScope) ->
    $scope          = $rootScope.$new()
    LoginController = $controller 'LoginController', $scope: $scope
    
    
  # =============================================
  # Tests
  # =============================================
  describe 'clickLoginButtonHandler', ->
    it 'defines scope.user', ()->
      expect($scope.user).toBeDefined()


  describe 'Attributes', ->
    it 'Should define facebookOptions', ->
      expect(LoginController.facebookOptions).toBeDefined() 
