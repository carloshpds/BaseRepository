"use strict"

# ======================================
# Imports
# ======================================


# ======================================
# PlayState class
# ======================================
class PlayState

  # ==========================
  # Override Methods
  # ==========================
  create: =>
    @game.physics.startSystem Phaser.Physics.ARCADE
    @sprite               = @game.add.sprite(@game.width / 2, @game.height / 2, "ball")
    @sprite.inputEnabled  = true
    @game.physics.arcade.enable @sprite
    @sprite.body.collideWorldBounds = true
    @sprite.body.bounce.setTo 1, 1
    @sprite.body.velocity.x = @game.rnd.integerInRange(-500, 500)
    @sprite.body.velocity.y = @game.rnd.integerInRange(-500, 500)
    @sprite.events.onInputDown.add @clickHandler, @

  update: ->

  # ==========================
  # Handlers
  # ==========================
  clickHandler: =>
    @game.state.start "game-over-state"

  # ==========================
  # Additional Method
  # ==========================
  
  # ==========================
  # Aux Methods
  # ==========================


# ======================================
# Export module
# ======================================
module.exports = PlayState