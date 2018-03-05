local FightScreen=Class("FightScreen")

Snake = require "src/bean/SnakeBean"
Friend = require "src/bean/FriendBean"
Enemy = require "src/bean/EnemyBean"

function FightScreen:init(game)
	self.game = game
	self.fightState = "fight"
	self.enemys = {}
	self.snake = Snake(100,100)
	self.friend = Friend()
	self.beganTime = os.time()
	self.time = os.time()-self.beganTime
	self.endStayTime = 0
	self.gameOver = love.graphics.newImage("res/gameOver.png")
	self.back = love.graphics.newImage("res/back.png")
	self.winWidth = love.graphics.getWidth()
end

function FightScreen:draw()
	for i=1,#self.enemys do
		self.enemys[i]:draw()
	end
	self.friend:paint()
	self.snake:paint()
	love.graphics.setColor(255,0,0)
	self:useTTFFont("人物血量--"..tostring(self.friend.hp),self.winWidth-300,100,25)	
	love.graphics.setColor(255,255,255)
	self:useTTFFont("蛇的长度--"..tostring(#self.snake.bodys+2),self.winWidth-300,125,25)
	if self.fightState == "end" or self.fightState == "0" then
		love.graphics.draw(self.gameOver,380,200)
		love.graphics.setColor(255,0,0)
		self:useTTFFont(self.endStayTime,650,265,24)
		love.graphics.setColor(255,255,255)
	else
		self:useTTFFont("坚持时间--"..tostring(self.time),self.winWidth-300,150,25)
		love.graphics.draw(self.back,20,20)
	end
end

local frame = 0
function FightScreen:update(dt)
	frame = frame + 1
	self.time = os.time()-self.beganTime
	if self.friend.hp == 0 and self.fightState ~= "0" then
		self.fightState = "end"
	end
	self:doGame()
end

function FightScreen:doGame()
	if self.fightState == "fight" then
		self:DoFightLogic()
		self:CreateEnemy()
	elseif self.fightState == "end" then
		self.endStayTime = os.time() - self.beganTime
		self.fightState = "0"
	end
end

function FightScreen:DoFightLogic()
	if frame % 5 == 0 then
		self.snake:isCrossBorder()
		self.snake:move()
		self.snake:check(self.enemys)
		self.friend:check(self.enemys)
		for j=1,#self.enemys do
			self.enemys[j]:moveToTarget(love.graphics.getWidth()/2,love.graphics.getHeight()/2)
		end
	end
end

local enemyMaxSpeed = 0
local addSpeedTime = 100
function FightScreen:CreateEnemy()
	if frame % 100 == 0 then
		if addSpeedTime > 1 then
			addSpeedTime = addSpeedTime - 1
		end
	end
	if frame % 1000 == 0 then
		if enemyMaxSpeed < 20 then
			enemyMaxSpeed = enemyMaxSpeed + 1
		end
	end
	if frame % addSpeedTime == 0 then
		table.insert(self.enemys,Enemy(enemyMaxSpeed))
	end
end

function FightScreen:keypressed(key)
	if key == "left" then
		self.snake:setDirction(1)
	elseif key == "right" then 
		self.snake:setDirction(2)
	elseif key == "up" then 
		self.snake:setDirction(3)
	elseif key == "down" then 
		self.snake:setDirction(4)
	elseif key == "appback" then
		self.game.state = "home"
	elseif key == "apphome" then
		self.game.state = "home"
	elseif key == "0" then
		self.game.state = "home"
	end
end

function FightScreen:mousepressed(x,y,button,istouch)
	if self.fightState == "0" then
		self.game.state = "home"
	else
		if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
		end
	end
end

function FightScreen:touchmoved( id, x, y, dx, dy, pressure )
	if math.abs(dx)>math.abs(dy) then
		if dx>0 then self.snake:setDirction(2) elseif dx<0 then self.snake:setDirction(1) end
	else
		if dy>0 then self.snake:setDirction(4) elseif dy<0 then self.snake:setDirction(3) end
	end
end

function FightScreen:touchpressed( id, x, y, dx, dy, pressure )
	if self.fightState == "0" then
		self.game.state = "home"
	else
		if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
		end
	end
end

local isInit=true
function FightScreen:useTTFFont(text,x,y,size)
	if isInit then
		local font=love.graphics.newFont("font/cn.ttf",size)
		love.graphics.setFont(font)
		isInit = false
	end
    love.graphics.print(text,x,y)
end

return FightScreen










