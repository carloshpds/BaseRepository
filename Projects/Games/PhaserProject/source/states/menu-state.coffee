"use strict"

# ======================================
# Imports
# ======================================


# ======================================
# MenuState class
# ======================================
class MenuState 
  
  # ==========================
  # Override Method
  # ========================== 
  preload: ->
    template = @game.state.getCurrentState().template

    @load.image('background', template.get('background'))
    @load.image('buttonPlayNormal', template.get('button_img'))
    @animated = template.get('animated')

  create: ->
    @background = @game.add.sprite(@game.world.centerX, @game.world.centerY, 'background')
    @background.anchor.setTo(0, 0.5)
    @background.x = 0

    buttonPlay = @game.add.button(@game.world.centerX, @game.world.centerY + 100, 'buttonPlayNormal', @buttonPressed, @, 0, 0, 0)
    buttonPlay.anchor.setTo(0.5, 0.5)

    if @animated
      @game.add.tween(@background).to({x: -150}, 10000, Phaser.Easing.Linear.NONE, true, 0, 10000, true)

  update: ->

  # ==========================
  # Handlers
  # ==========================
  buttonPressed: (btn) =>
    @game.state.start('play-state')

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

  