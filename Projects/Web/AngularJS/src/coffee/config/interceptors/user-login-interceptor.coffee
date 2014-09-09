
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
  
  # =============================================
  # Check Logged User on $stateChangeStart
  # =============================================
  .run ['$rootScope', '$injector', ($rootScope, $injector) ->

    $rootScope.$on '$stateChangeStart',  (event, toState, toParams, fromState, fromParams) ->
      $injector.invoke ['UserService', 'LoggedUserFactory', '$state', (UserService, LoggedUserFactory, $state) ->
        if toState.data.restrict
          promise         = UserService.getLoggedUserInfo()
          promise.success (data) -> 
            LoggedUserFactory.set data
            $state.transitionTo(toState, toParams, notify : no).then( ->
              $rootScope.$broadcast '$stateChangeSuccess', toState, toParams, fromState, fromParams
            )
          promise.error  (data, status, headers, config)       -> 
            if status is 401
              LoggedUserFactory.set null 
              $state.transitionTo 'login.productOfInterest'
        return
      ]
  ]
    
    