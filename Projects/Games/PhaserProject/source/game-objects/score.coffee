

# ======================================
# Imports
# ======================================


# ======================================
# TimerCount class
# ======================================
class Score

  # ==========================
  # Override Method
  # ==========================
	constructor: (game, name, x, y, font) ->
    @counter  = 0
    @name     = name
    @label    = game.add.text(x, y, '', font)
    @label.anchor.setTo(1, 0)
    @refresh()

  # ==========================
  # Handlers
  # ==========================
  
  # ==========================
  # Additional Method
  # ==========================
  increment: () =>
    @counter++
    @refresh()

  incrementcounter: (increment) =>
    @counter += increment
    @refresh()
  
  # ==========================
  # Aux Methods
  # ==========================
  refresh: () =>
    @label.setText(@name + ': ' + @counter);

# ======================================
# Export module
# ======================================
module.exports = Score