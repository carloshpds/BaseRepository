'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'

  # =============================================
  # NotificationsFactory
  # =============================================
  .factory 'NotificationsFactory', ['$rootScope', '$timeout', ($rootScope, $timeout) ->

    # Variables
    # ==========================
    $rootScope.notifications = []
    timeout       = undefined

    # Clear notifications
    # ==========================
    clearNotifications = ->
      $rootScope.notifications = []
      timeout       = undefined

    # Add notification
    # ==========================
    add: (notification) ->
      $rootScope.notifications.push notification
      timeout = $timeout(
        ->
          do clearNotifications
        , 5000
      )
  ]



