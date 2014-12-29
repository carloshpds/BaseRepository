'use strict';
describe('Controller: LoginController', function() {
  var $scope, LoginController;
  beforeEach(module('ui.router'));
  beforeEach(module('ui.bootstrap'));
  beforeEach(module('MyAngularOmakase.scripts'));
  beforeEach(module('stateMock'));
  $scope = null;
  LoginController = null;
  beforeEach(inject(function($controller, $rootScope, _LoginService_, _$state_, _$modal_) {
    $scope = $rootScope.$new();
    return LoginController = $controller('LoginController', {
      LoginService: _LoginService_,
      $scope: $scope,
      $state: _$state_,
      $modal: _$modal_
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
