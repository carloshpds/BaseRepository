'use strict';

var GameTemplate = require('../game/templates/games/game-2');
var MenuTemplate = require('../game/templates/menus/menu-2');

//global variables
window.onload = function () {
  var game = new Phaser.Game(<%= gameWidth %>, <%= gameHeight %>, Phaser.AUTO, '<%= _.slugify(projectName) %>');

  // Game States
  <% _.forEach(gameStates, function(gameState) {  %>
  game.state.add('<%= gameState.shortName %>', require('./states/<%= gameState.shortName %>'));
  <% }); %>

  game.state.states['play-state'].template = new GameTemplate();
  game.state.states['menu-state'].template = new MenuTemplate();

  game.state.start( '<%= _.first(gameStates).shortName %>');
};