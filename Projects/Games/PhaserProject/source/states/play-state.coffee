"use strict"

# ======================================
# Imports
# ======================================
TimerCount  = require '../game-objects/timer'
Score       = require '../game-objects/score'
ObjectFall  = require '../game-objects/object-fall'
TiledGround = require '../game-objects/tiled-ground'
Player      = require '../game-objects/player'

# ======================================
# PlayState class
# ======================================
class PlayState

  # ==========================
  # Override Methods
  # ==========================
  preload: =>
    template = @game.state.getCurrentState().template

    @objects = [];

    # Game Background
    @game.stage.backgroundColor = template.get('background_color')

    # Objects falling
    @group_falling = @game.add.group()
    objects_falling = template.get('objects_falling')
    
    for obj,index in objects_falling
      key = 'obj_fall_' + index
      @objects[index] = key
      @load.image(@objects[index], objects_falling[index])

    # Game font
    @fontScore = template.get('game_font')

    # Ground
    @load.image('groundTile', template.get('ground_tile'))
    @groundTileSize = template.get('ground_tile_size')

    # Player config
    playerConfig = template.get('player')
    @game.load.spritesheet('player', playerConfig.spritesheet, playerConfig.width, playerConfig.height)

  create: =>
    @game.physics.startSystem(Phaser.Physics.ARCADE)

    new TiledGround(@game, @groundTileSize.width, @groundTileSize.height, 'groundTile')
    new TimerCount(@game, 'Timer', 20, 10, @fontScore);

    @player = new Player(@game, @game.world.centerX, @game.height - @groundTileSize.height)
    @score = new Score(@game, 'Score', @game.width - 20, 10, @fontScore)

    @game.time.events.loop(Phaser.Timer.SECOND, @createNewGift, @)

  update: ->
    @player.update()
    @game.physics.arcade.collide(@player.player, @group_falling, @collisionHandler, null, @)

  # ==========================
  # Handlers
  # ==========================
  createNewGift: () =>
    objFall = new ObjectFall(@game, @objects)
    @group_falling.add(objFall)

  collisionHandler: (player, object) =>
    object.kill()
    @score.increment()

  # ==========================
  # Additional Method
  # ==========================
  
  # ==========================
  # Aux Methods
  # ==========================


# ======================================
# Export module
# ======================================
module.exports = PlayState