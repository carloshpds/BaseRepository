

# ======================================
# Imports
# ======================================

# ======================================
# GameObject class
# ======================================
class Game1

  # ==========================
  # Override Method
  # ==========================
	constructor: () ->
    @values = {
      'background_color': '#000000',

      'objects_falling': [
        'assets/Gift_Blue.png',
        'assets/Gift_Red.png',
        'assets/Gift_Yellow.png'
      ],

      'ground_tile': 'assets/ground.png',
      'ground_tile_size' : {
        'width': 60,
        'height': 60 
      },

      'game_font': {
        'font': "16px Arial", 
        'fill': "#ffffff", 
        'align': "center"
      },

      'player': {
        'spritesheet': 'assets/dude.png',
        'width': 40,
        'height': 60
      }
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
module.exports = Game1