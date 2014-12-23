'use strict';
describe('Controller: LoginController', function() {
  var $scope, LoginController;
  beforeEach(module('MyAngularOmakase.scripts'));
  beforeEach(module('ui.router'));
  $scope = null;
  LoginController = null;
  beforeEach(inject(function($controller, $rootScope) {
    $scope = $rootScope.$new();
    return LoginController = $controller('LoginController', {
      $scope: $scope
    });
  }));
  describe('clickLoginButtonHandler', function() {
    return it('defines scope.user', function() {
      return expect($scope.user).toBeDefined();
    });
  });
  return describe('Attributes', function() {
    return it('Should define facebookOptions', function() {
      return expect(LoginController.facebookOptions).toBeDefined();
    });
  });
});
