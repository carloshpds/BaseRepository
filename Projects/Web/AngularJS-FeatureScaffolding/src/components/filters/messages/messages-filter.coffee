'use strict'

# =============================================
# Module
# =============================================
angular.module 'MyAngularOmakase.filters' 

  .filter 'EnumMessagesFilter', [ ->
    # Portuguese Messages
    # ==========================
    @messagesPTBR =

      # General Messages
      # ==========================
    
      # Success Messages
      # ==========================
      
      # Error Messages
      # ==========================
     
      # User Messages
      # ==========================
      "user.does.not.exist"       : "Usuário não encontrado"
      "username.already.exists"   : "Nome de usuário já existente"

    @get = (property) ->
      return @messagesPTBR["#{property}"]

    @getAll = ->
      return @messagesPTBR

    @filter = ->
      get     : @get
      getAll  : @getAll 

    return @filter

  ]

