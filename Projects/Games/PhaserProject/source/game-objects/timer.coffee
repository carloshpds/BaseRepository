

# ======================================
# Imports
# ======================================


# ======================================
# TimerCount class
# ======================================
class TimerCount

  # ==========================
  # Override Method
  # ==========================
	constructor: (game, name, x, y, font) ->
    @counter  = 0
    @name     = name
    @label    = game.add.text(x, y, @name + ': 0', font)
    game.time.events.loop(Phaser.Timer.SECOND, @increment, @)

  # ==========================
  # Handlers
  # ==========================
  increment: () =>
    @counter++
    @label.setText(@name + ': ' + @counter)
  
  # ==========================
  # Additional Method
  # ==========================
  
  
  # ==========================
  # Aux Methods
  # ==========================

# ======================================
# Export module
# ======================================
module.exports = TimerCount