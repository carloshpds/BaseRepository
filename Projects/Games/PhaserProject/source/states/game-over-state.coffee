"use strict"

# ======================================
# Imports
# ======================================


# ======================================
# GameOverState class
# ======================================
class GameOverState
  
  # ==========================
  # Override Method
  # ==========================
  preload: ->

  create: =>
    style =
      font: "65px Arial"
      fill: "#ffffff"
      align: "center"

    @titleText = @game.add.text(@game.world.centerX, 100, "Game Over!", style)
    @titleText.anchor.setTo 0.5, 0.5
    @instructionText = @game.add.text(@game.world.centerX, 300, "Click To Play Again",
      font: "16px Arial"
      fill: "#ffffff"
      align: "center"
    )
    @instructionText.anchor.setTo 0.5, 0.5

  update: =>
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
module.exports = GameOverState