'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.directives'

  # =============================================
  # __directiveName__
  # =============================================
  .directive '__directiveName__', [ () ->
    restrict: '__restrict__'
    replace : yes
    scope: __scope__
    template:"""
      @cursor
    """
  ]
