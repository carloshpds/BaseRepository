

# ======================================
# Imports
# ======================================
Prefab = require "../base/prefab-base"

# ======================================
# TimerCount class
# ======================================
class TiledGround extends Prefab

  # ==========================
  # Override Method
  # ==========================
  constructor: (game, width, height, tile) ->
    @game  = game
    @group = @game.add.group()

    posX = 0
    posY = @game.height
    while(posX < @game.width)
        ground = @group.create(posX, posY, tile)
        ground.anchor.setTo(0, 1)
        posX = posX + width

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
module.exports = TiledGround