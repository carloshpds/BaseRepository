'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.directives'
  .directive 'notifyOnFinishNgRepeat', ['$timeout', '$rootScope', ($timeout, $rootScope) ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      if scope.$last is true  
        eventModeEmit      = 'emit'
        eventModeBroadcast = 'broadcast'

        finishEventName     = attrs.finishEventName or "list"
        publishMode         = attrs.notifyPublishMode     or eventModeEmit
        currentScopeEvent   = if attrs.notifyByRoot then $rootScope else scope

        if publishMode is eventModeEmit
          $timeout -> currentScopeEvent.$emit("#{finishEventName}")
        else if publishMode is eventModeBroadcast
          $timeout -> currentScopeEvent.$broadcast("#{finishEventName}")
  ]
