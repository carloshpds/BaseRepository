'use strict';
angular.module('stateMock', []);

angular.module('stateMock').service("$state", function($q) {
  this.expectedTransitions = [];
  this.current = {};
  this.transitionTo = function(stateName) {
    var deferred, expectedState, promise;
    if (this.expectedTransitions.length > 0) {
      expectedState = this.expectedTransitions.shift();
      if (expectedState !== stateName) {
        throw Error("Expected transition to state: " + expectedState + " but transitioned to " + stateName);
      }
    } else {
      throw Error("No more transitions were expected! Tried to transition to " + stateName);
    }
    console.log("Mock transition to: " + stateName);
    this.current.name = stateName;
    deferred = $q.defer();
    promise = deferred.promise;
    deferred.resolve();
    return promise;
  };
  this.go = this.transitionTo;
  this.is = function(stateName) {
    if (this.current.name === stateName) {
      return true;
    }
    return false;
  };
  this.expectTransitionTo = function(stateName) {
    return this.expectedTransitions.push(stateName);
  };
  this.ensureAllTransitionsHappened = function() {
    if (this.expectedTransitions.length > 0) {
      throw Error("Not all transitions happened!");
    }
  };
});
