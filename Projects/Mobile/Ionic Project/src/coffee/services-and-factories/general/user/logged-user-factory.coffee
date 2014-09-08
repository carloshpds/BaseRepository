'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # LoggedUserFactory
  # =============================================
  .factory 'LoggedUserFactory', () ->

    loggedUser = null

    get: (property) ->
      if property then loggedUser["#{property}"] else loggedUser

    set: (user) ->
      loggedUser = user
