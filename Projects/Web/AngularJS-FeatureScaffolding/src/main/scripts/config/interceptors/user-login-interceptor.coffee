
# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase'


  # =============================================
  # Config
  # =============================================
  .config( ['$httpProvider', '$provide', ($httpProvider, $provide) -> 
    
    # =============================================
    # UserLoginInterceptor
    # =============================================
    $provide.factory 'UserLoginInterceptor', [ '$q', '$injector', ($q, $injector) ->
      
      'request': (config) ->
        return config
          
      'requestError': (rejection)->
        return $q.reject rejection

      'response': (response)-> 
        return response or $q.when response

      'responseError': (rejection)->
        if rejection.status is 401
          $injector.invoke ['$state', 'LoggedUserFactory', 'NotLoggedUserStates', ($state, LoggedUserFactory, NotLoggedUserStates) ->
            if $state.current.data.restrict
              LoggedUserFactory.set null 
              $state.go 'login'
          ]

        return  $q.reject rejection
 
    ]

    # =============================================
    # Register Interceptor
    # =============================================
    $httpProvider.interceptors.push 'UserLoginInterceptor'

  ])
    
    