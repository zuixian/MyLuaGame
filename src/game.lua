local game=Class("game")

FightScreen = require "src/screen/FightScreen"
HomeScreen = require "src/screen/HomeScreen"
HelpScreen = require "src/screen/HelpScreen"
ChangeBgScreen = require "src/screen/ChangeBgScreen"
Bg = require "src/Bg"

function game:init()
	self.state = "home"
	self.screen = HomeScreen(self)
	self.isPaly = true
	self.bg = Bg()
	self.bgm = love.audio.newSource("res/bgm.mp3")
end

function game:draw()
	self.bg:draw()
	self.screen:draw()
end

function game:update()
	self:doGameLogic()
	self.screen:update()
	if self.isPaly then
		love.audio.play(self.bgm)
	else
		love.audio.pause(self.bgm)
	end
end

function game:doGameLogic()
	if self.state == "fight" then
		self.screen = FightScreen(self)
	elseif self.state == "home" then
		self.screen = HomeScreen(self)
	elseif self.state == "help" then
		self.screen = HelpScreen(self)
	elseif self.state == "changeBg" then
		self.screen = ChangeBgScreen(self,self.bg)
	elseif self.state == "quit" then
		love.event.quit()
	end
	self.state = "runState"
end


function game:touchpressed( id, x, y, dx, dy, pressure )
	self.screen:touchpressed( id, x, y, dx, dy, pressure )
end

function game:keypressed(key)
	self.screen:keypressed(key)
end

function game:mousepressed(x,y,button,istouch)
	self.screen:mousepressed(x,y,button,istouch)
end

function game:touchmoved( id, x, y, dx, dy, pressure )
	self.screen:touchmoved( id, x, y, dx, dy, pressure )
end


return game

