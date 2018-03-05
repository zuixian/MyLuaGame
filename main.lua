Class = require "libs/middleclass"
require "myLualib"
Game = require "src/game"

function love.load()
	game = Game()
end

function love.draw()
	game:draw()
end

function love.update(dt)
	game:update()
end

function love.keypressed(key,scancode,isrepeat)
	game:keypressed(key)
end

function love.mousepressed( x, y, button, istouch )
	game:mousepressed(x,y,button,istouch)
end

function love.touchmoved( id, x, y, dx, dy, pressure )
	game:touchmoved( id, x, y, dx, dy, pressure )
end

function love.touchpressed( id, x, y, dx, dy, pressure )
	game:touchpressed( id, x, y, dx, dy, pressure )
end

