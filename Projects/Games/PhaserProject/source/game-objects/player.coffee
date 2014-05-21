

# ======================================
# Imports
# ======================================
Prefab = require "../base/prefab-base"

# ======================================
# TimerCount class
# ======================================
class Player extends Prefab

  # ==========================
  # Override Method
  # ==========================
  constructor: (game, x, y) ->
    @game = game

    @player = @game.add.sprite(x, y, 'player')
    @player.anchor.setTo(0.5, 1)
    @game.physics.enable(@player, Phaser.Physics.ARCADE)
    @game.physics.arcade.enableBody(@player)

    @player.body.collideWorldBounds = true
    @player.body.allowGravity = false
    @player.body.immovable = true

    @player.animations.add('left', [0, 1, 2, 3], 10, true)
    @player.animations.add('turn', [4], 20, true)
    @player.animations.add('right', [5, 6, 7, 8], 10, true)

    @cursors = @game.input.keyboard.createCursorKeys()
    @pointer = @game.input.pointer1

    @midScreen = @game.width / 2

    @facing = 'left'
    @velocity = 300

  update: () =>
    @player.body.velocity.x = 0

    if (@cursors.left.isDown || (@pointer.isDown && @pointer.position.x < @midScreen) )
        @player.body.velocity.x = -@velocity
        if (@facing != 'left')
            @player.animations.play('left')
            @facing = 'left'

    else if (@cursors.right.isDown || (@pointer.isDown && @pointer.position.x >= @midScreen) )
        @player.body.velocity.x = @velocity
        if (@facing != 'right')
            @player.animations.play('right')
            @facing = 'right'
    else
        if (@facing != 'idle')
            @player.animations.stop()
            if (@facing == 'left')
                @player.frame = 0
            else
                @player.frame = 5

            @facing = 'idle'

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
module.exports = Player