"use strict"

# ======================================
# Imports
# ======================================


# ======================================
# BootState class
# ======================================
class BootState 
  
  # ==========================
  # Override Method
  # ==========================
  preload: ->
    @load.image "preloader", "assets/preloader.gif"
    
  create: ->
    @game.input.maxPointers = 1
    @game.state.start "preload-state"

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
module.exports = BootState