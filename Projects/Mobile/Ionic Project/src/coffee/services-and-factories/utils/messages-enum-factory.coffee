'use strict'

# =============================================
# Module
# =============================================
angular.module 'IonicProjectModelApp'
  
  # =============================================
  # MessagesEnumsFactory
  # =============================================
  .factory 'MessagesEnumsFactory', () ->
    
    # Portuguese Messages
    # ==========================
    messagesPTBR =

      # General Messages
      # ==========================
      "general.pulling.text"        : "puxe e solte para sincronizar..."

      # Success Messages
      # ==========================
      "successful.occurrence.vote"  : "Seu voto foi efetuado =)"
      
      # Error Messages
      # ==========================
      "incident.invalid.time.to.create.incident"    : "Só é permitido votar uma vez por minuto"

      # User Messages
      # ==========================
      "user.does.not.exist"       : "Usuário não encontrado"
      "username.already.exists"   : "Nome de usuário já existente"

    get: (property) ->
      if property then messagesPTBR["#{property}"] else messagesPTBR
