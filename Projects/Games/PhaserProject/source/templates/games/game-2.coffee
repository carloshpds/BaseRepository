

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
      'background_color': '#E8BB41',

      'objects_falling': [
        'assets/soccerball.png'
      ],

      'ground_tile': 'assets/grass.png',
      'ground_tile_size' : {
        'width': 75,
        'height': 75 
      },

      'game_font': {
        'font': "32px Arial", 
        'fill': "#4F4F4F", 
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