io.stdout:setvbuf('no') --For Console output in IDEs

<<<<<<< Updated upstream
<<<<<<< HEAD
=======

>>>>>>> experimental
require "torch"
require "cutorch"
=======
require 'torch'
--require 'cutorch'
>>>>>>> Stashed changes


scale = require 'code/scale'
--statemachine:
state = require 'code/exlib/gamestate'
--states:
splash = require 'code/states/splash'
mainmenu = require 'code/states/mainmenu'
test = require 'code/states/test'

function love.load()
<<<<<<< Updated upstream
  if arg[#arg] == "-debug" then require("mobdebug").start() end --For Zerobrane Debugging
<<<<<<< HEAD
  state.registerEvents()
  state.switch(splash)
=======
>>>>>>> experimental
=======
  if arg[#arg] == '-debug' then require('mobdebug').start() end --For Zerobrane Debugging
  state.registerEvents()
  state.switch(splash)
  love.joystick.loadGamepadMappings("res/gamecontrollerdb.txt")
>>>>>>> Stashed changes
end

function love.update(dt)
  
end

function love.draw()
  
end

function love.resize(w,h)
  scale:resize(w,h)
end