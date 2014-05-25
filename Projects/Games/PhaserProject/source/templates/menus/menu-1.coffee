

# ======================================
# Imports
# ======================================

# ======================================
# GameObject class
# ======================================
class Menu1

  # ==========================
  # Override Method
  # ==========================
	constructor: () ->
    @values = {
      'background': 'assets/background.png',
      'button_img': 'assets/button_start_game.png',
      'animated': true
    }

  # ==========================
  # Handlers
  # ==========================
  
  # ==========================
  # Additional Method
  # ==========================
  get: (key) => 
    return @values[key];
  
  # ==========================
  # Aux Methods
  # ==========================

# ======================================
# Export module
# ======================================
module.exports = Menu1