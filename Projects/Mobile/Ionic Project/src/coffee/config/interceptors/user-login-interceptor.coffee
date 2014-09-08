
# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'


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
            unless _.contains(NotLoggedUserStates, $state.current.name)
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
  # URLS for not logged user
  # =============================================
  .constant 'NotLoggedUserStates', [
    'login'
    'sign-up'
    ]

  # =============================================
  # Check Logged User on $stateChangeStart
  # =============================================
  .run ['$rootScope', '$injector', ($rootScope, $injector) ->

    $rootScope.$on '$stateChangeStart',  (event, toState, toParams, fromState, fromParams) ->

      $injector.invoke ['UserService', 'LoggedUserFactory', '$state', 'NotLoggedUserStates', '$urlRouter', (UserService, LoggedUserFactory, $state, NotLoggedUserStates, $urlRouter) ->

        unless _.contains(NotLoggedUserStates, toState.name)
          do event.preventDefault
          promise         = UserService.getLoggedUserInfo()
          promise.success (data) ->
            LoggedUserFactory.set data
            $state.transitionTo(toState, toParams, notify : no).then( ->
              $rootScope.$broadcast '$stateChangeSuccess', toState, toParams, fromState, fromParams
            )
          promise.error  (data, status, headers, config) ->
            if status is 401
              LoggedUserFactory.set null
              $state.transitionTo 'login'

      ]
  ]

