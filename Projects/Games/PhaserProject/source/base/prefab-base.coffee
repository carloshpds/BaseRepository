
# ======================================
# PrefabBase class
# ======================================
class PrefabBase extends Phaser.Sprite
    
    # ==========================
    # Override Method
    # ==========================
    preload: ->
    
    constructor: (game, frame) ->
        Phaser.Sprite.call(this, game, 0, 0, 'yeoman', frame);

    update: ->
    
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
module.exports = PrefabBase