'use strict'


# =============================================
# Modules
# =============================================
angular.module 'MyAngularOmakase.controllers' , []
angular.module 'MyAngularOmakase.filters'     , []
angular.module 'MyAngularOmakase.factories'   , []
angular.module 'MyAngularOmakase.services'    , []
angular.module 'MyAngularOmakase.constants'   , []
angular.module 'MyAngularOmakase.directives'  , []


# =============================================
# Scripts Module
# =============================================
angular.module 'MyAngularOmakase.scripts'     , [
  'MyAngularOmakase.controllers'
  'MyAngularOmakase.constants'
  'MyAngularOmakase.filters'
  'MyAngularOmakase.factories'
  'MyAngularOmakase.services'
  'MyAngularOmakase.directives'
]


# =============================================
# Main Module
# =============================================
angular.module('MyAngularOmakase', [
  'ngSanitize'
  'QuickList'
  'ui.router'
  'ui.bootstrap'
  'MyAngularOmakase.scripts'
])


  # =============================================
  # Initialize
  # =============================================
  .run([ () ->

    # Import underscore-string to underscore
    # =================================
    _.mixin(_.string.exports())

    # Change Moment relative time
    moment.lang 'pt-br',
      relativeTime :
        future: "em %s"
        past:   "%s atrás"
        s:  "segundos"
        m:  "um minuto"
        mm: "%d minutos"
        h:  "uma hora"
        hh: "%d horas"
        d:  "um dia"
        dd: "%d dias"
        M:  "um mês"
        MM: "%d meses"
        y:  "um ano"
        yy: "%d anos"

    moment.lang('pt-br')

  ])

  # =============================================
  # httpProvider Config
  # =============================================
  .config( ['$httpProvider', ($httpProvider) ->

    # Customize $httpProvider
    # =============================================
    # $httpProvider.defaults.transformRequest  = (data) -> if data then $.param(data) else data
    # $httpProvider.defaults.headers.post      = "Content-Type": 'application/json'
  ])





