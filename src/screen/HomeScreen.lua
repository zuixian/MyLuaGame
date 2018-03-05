local HomeScreen = Class("HomeScreen")

SnakeBean=require "src/bean/SnakeBean"

function HomeScreen:init(game)
	self.game = game
	self.input = "home"
	self.title = love.graphics.newImage("res/title.png")
	self.began = love.graphics.newImage("res/began.png")
	self.help = love.graphics.newImage("res/help.png")
	self.quit = love.graphics.newImage("res/quit.png")
	self.pmusic = love.graphics.newImage("res/pmusic.png")
	self.nmusic = love.graphics.newImage("res/nmusic.png")
	self.xiangji = love.graphics.newImage("res/xiangji.png")
	self.snake1 = SnakeBean(300,300)
	self.snake1:setDirction(1)
	self.winWidth = love.graphics.getWidth()
	self.winHeight = love.graphics.getHeight()
end

function HomeScreen:draw()
	love.graphics.draw(self.title,20+self.winWidth/2,40,0,1,1,self.title:getWidth()/2,0)
	love.graphics.draw(self.began,self.winWidth/2,(self.winHeight/3)+40,0,1,1,self.began:getWidth()/2,self.began:getHeight()/2)
	love.graphics.draw(self.help,self.winWidth/2,(self.winHeight/3) +180,0,1,1,self.help:getWidth()/2,self.help:getHeight()/2)
	love.graphics.draw(self.quit,self.winWidth/2,(self.winHeight/3) +320,0,1,1,self.quit:getWidth()/2,self.quit:getHeight()/2)
	self.snake1:paint()
	love.graphics.draw(self.xiangji,self.winWidth-200,self.winHeight/2+100)
	if self.game.isPaly then
		love.graphics.draw(self.pmusic,self.winWidth-200,self.winHeight/2-100)
	else
		love.graphics.draw(self.nmusic,self.winWidth-200,self.winHeight/2-100)
	end
end

local i = 0
local dir = {4,2,3,1}
local j = 1
local p = 1
function HomeScreen:update(dt)
	if self.input == "began" then 
		self.game.state = "fight"
	elseif self.input == "help" then 
		self.game.state = "help"
	elseif self.input == "changeBg" then 
		self.game.state = "changeBg"
	elseif self.input == "quit" then
		self.game.state = "quit"
	end
	self.input = "home"
	if p == 5 then
		self.snake1:move()
		if i == 4 then
			self.snake1:setDirction(dir[j])
			j = j + 1
			if j == 5 then
				j = 1
			end
			i = 0
		end
		i = i + 1
		p = 0
	end
	p = p + 1
end

function HomeScreen:keypressed(key)

end

function HomeScreen:mousepressed(x,y,button,istouch)
	if (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3)+40 - 56)) and (y < ((self.winHeight/3)+40 + 56))  then
		self.input = "began"
	elseif (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3) +180 - 56)) and (y < ((self.winHeight/3) +180 + 56)) then
		self.input = "help"
	elseif x < (self.winWidth-100) and x > self.winWidth-200 and y<self.winHeight/2 +200 and y > self.winHeight/2 +100 then
		self.input = "changeBg"
	elseif (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3) +320 - 56)) and (y < ((self.winHeight/3) +320 + 56)) then
		self.input = "quit"
	end
	
	if x < (self.winWidth-100) and x > self.winWidth-200 and y<self.winHeight/2 and y > self.winHeight/2-100 then
		if self.game.isPaly == true then  
			self.game.isPaly = false
		else
			self.game.isPaly = true
		end
	end
end

function HomeScreen:touchmoved( id, x, y, dx, dy, pressure )
	
end

function HomeScreen:touchpressed( id, x, y, dx, dy, pressure )
	if (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3)+40 - 56)) and (y < ((self.winHeight/3)+40 + 56))  then
		self.input = "began"
	elseif (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3) +180 - 56)) and (y < ((self.winHeight/3) +180 + 56)) then
		self.input = "help"
	elseif (x > (self.winWidth/2 - 175)) and (x < (self.winWidth/2 + 175)) and (y > ((self.winHeight/3) +320 - 56)) and (y < ((self.winHeight/3) +320 + 56)) then
		self.input = "quit"
	end
end

return HomeScreen