"use strict"

# ======================================
# Imports
# ======================================


# ======================================
# PreloadState class
# ======================================
class PreloadState
  
  # ==========================
  # Override Method
  # ==========================
  preload: ->
    @asset = @add.sprite(@width / 2, @height / 2, "preloader")
    @asset.anchor.setTo 0.5, 0.5

    @load.onLoadComplete.addOnce @onLoadCompleteHandler, @
    @load.setPreloadSprite       @asset
    @load.image                  "ball", "assets/ball.png"

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start "menu-state"  if @ready

  # ==========================
  # Handlers
  # ========================== 
  onLoadCompleteHandler: ->
    @ready = true

  # ==========================
  # Additional Method
  # ==========================
  
  # ==========================
  # Aux Methods
  # ==========================

# ======================================
# Export module
# ====================================== 
module.exports = PreloadState