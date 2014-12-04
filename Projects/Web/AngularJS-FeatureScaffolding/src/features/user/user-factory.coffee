'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.factories'
  
  # =============================================
  # LoggedUserFactory
  # =============================================
  .factory 'LoggedUserFactory', () ->

    loggedUser = null

    get: (property) ->
      if property then loggedUser["#{property}"] else loggedUser

    set: (user) ->
      loggedUser = user
