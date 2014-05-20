"use strict"

# ======================================
# Imports
# ======================================
Ball = require '../game-objects/game-object'

# ======================================
# MenuState class
# ======================================
class MenuState 
  
  # ==========================
  # Override Method
  # ========================== 
  preload: ->

  create: ->
    style =
      font: "65px Arial"
      fill: "#ffffff"
      align: "center"

    @sprite = @game.add.sprite(@game.world.centerX, 138, "ball")
    @sprite.anchor.setTo 0.5, 0.5
    @titleText = @game.add.text(@game.world.centerX, 300, "Phaser Game Example!", style)
    @titleText.anchor.setTo 0.5, 0.5
    @instructionsText = @game.add.text(@game.world.centerX, 400, "Click anywhere to play!",
      font: "16px Arial"
      fill: "#ffffff"
      align: "center"
    )
    @instructionsText.anchor.setTo 0.5, 0.5
    @sprite.angle = -20
    @game.add.tween(@sprite).to
      angle: 20
    , 1000, Phaser.Easing.Linear.NONE, true, 0, 1000, true

  update: ->
    @game.state.start "play-state"  if @game.input.activePointer.justPressed()

  # ==========================
  # Handlers
  # ==========================

  # ==========================
  # Additional Method
  # ==========================
  
  
  # ==========================
  # Aux Methods
  # ==========================

# ======================================
# Export module
# ======================================
module.exports = MenuState

  