'use strict'

# ======================================
# Imports
# ======================================
Prefab = require "../base/prefab-base"

# ======================================
# TimerCount class
# ======================================
class ObjectFall extends Prefab

  # ==========================
  # Override Method
  # ==========================
	constructor: (game, gifts, frame) ->
    gift  = game.rnd.integerInRange(0, gifts.length - 1)
    x     = game.rnd.integerInRange(100, 700)

    Phaser.Sprite.call(@, game, x, -50, gifts[gift], frame)
    @anchor.setTo(0.5, 0.5)

    @game.physics.enable(@, Phaser.Physics.ARCADE)
    @game.physics.arcade.enableBody(@)
    @body.gravity.y = game.rnd.integerInRange(150, 300)

    @game.add.existing(@)

  update:() =>
    if(@y > @game.height + @height)
      @kill()

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
module.exports = ObjectFall