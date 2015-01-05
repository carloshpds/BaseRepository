'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.directives'

  .directive 'forkMeOnGithub', [ () ->
    restrict: 'A'
    replace : yes
    scope: 
      href: "@"
    template:"""
      <a href="{{href}}" target="_blank" class="fork-me-on-github"></a>
    """
  ]
