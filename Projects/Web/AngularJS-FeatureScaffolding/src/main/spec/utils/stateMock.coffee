'use strict'

angular.module('stateMock', [])

angular.module('stateMock')
  
  .service "$state", ['$q', ($q) -> 
    @expectedTransitions = []
    @current             = {}
    @transitionTo        = (stateName) =>
      deferred      = null 
      expectedState = null 
      promise       = null

      if @expectedTransitions.length > 0
        expectedState = @expectedTransitions.shift()
        if expectedState isnt stateName
          throw Error("Expected transition to state: " + expectedState + " but transitioned to " + stateName)
      else 
        throw Error("No more transitions were expected! Tried to transition to " + stateName)
      
      console.log("Mock transition to: " + stateName)

      @current.name = stateName
      deferred      = $q.defer()
      promise       = deferred.promise
      deferred.resolve()
      return promise

    @go = @transitionTo
    @is = (stateName) => return @current.name is stateName
    
    @expectTransitionTo = (stateName) => 
      return @expectedTransitions.push(stateName)
    
    @ensureAllTransitionsHappened = () => 
      if @expectedTransitions.length > 0 then throw Error("Not all transitions happened!")
      
    
  ]
