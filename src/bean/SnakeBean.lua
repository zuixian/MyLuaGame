local SnakeBean=Class("SnakeBean")

local SnakeHead = require "src/bean/SnakeHead"
local SnakeTail = require "src/bean/SnakeTail"
local SnakeBody = require "src/bean/SnakeBody"


function SnakeBean:init(x,y)
	self.hp = 5
	self.bodys = {}
	self.dirction = 4
	self.snakeHead = SnakeHead(x,y,0)
	self.speed = self.snakeHead:getWidth()- 15
	self.width = self.snakeHead:getWidth()
	self.snakeTail = SnakeTail(x+self.width*4,y,0)
	table.insert(self.bodys,SnakeBody(x+self.width,y,0))
	table.insert(self.bodys,SnakeBody(x+self.width*2,y,0))
	table.insert(self.bodys,SnakeBody(x+self.width*3,y,0))
end

function SnakeBean:check(enemys)
	if self.snakeHead:check(enemys) then
		table.insert(self.bodys,SnakeBody(-10,-10,0))
	end
	local i = 1
	while i < #self.bodys do
        if self.bodys[i]:check(enemys)
		then
			self.hp = self.hp - 1
            table.remove(self.bodys,i)
        else
            i = i + 1
        end
    end
end

function SnakeBean:paint()
	self.snakeHead:paint()
	for i=1,#self.bodys,1 do
		self.bodys[i]:paint()
	end
	self.snakeTail:paint()
end

function SnakeBean:move()
	self.snakeTail.posX = self.bodys[#self.bodys].posX
	self.snakeTail.posY = self.bodys[#self.bodys].posY
	self.snakeTail.dirction = self.bodys[#self.bodys].dirction
	for i=#self.bodys,2,-1 do
		self.bodys[i].posX = self.bodys[i-1].posX
		self.bodys[i].posY = self.bodys[i-1].posY
		self.bodys[i].dirction = self.bodys[i-1].dirction
	end
	self.bodys[1].posX = self.snakeHead.posX
	self.bodys[1].posY = self.snakeHead.posY
	self.bodys[1].dirction = self.snakeHead.dirction
	if self.dirction == 1 then
		self.snakeHead:setPos(self.snakeHead.posX-self.speed,self.snakeHead.posY,0)
	elseif self.dirction == 2 then
		self.snakeHead:setPos(self.snakeHead.posX+self.speed,self.snakeHead.posY,180)
	elseif self.dirction == 3 then
		self.snakeHead:setPos(self.snakeHead.posX,self.snakeHead.posY-self.speed,90)
	elseif self.dirction ==4 then
		self.snakeHead:setPos(self.snakeHead.posX,self.snakeHead.posY+self.speed,-90)
	end
end

function SnakeBean:setDirction(d)
	self.dirction = d
end

function SnakeBean:isCrossBorder()
	local winHeight = love.graphics.getHeight()
	local winWidth = love.graphics.getWidth()
	local SposX = self.snakeHead.posX
	local SposY = self.snakeHead.posY
	if SposX - self.speed < 0 then
		self.dirction = 2
	end
	if SposX + self.speed > winWidth then
		self.dirction = 1
	end
	if SposY - self.speed < 0 then
		self.dirction = 4
	end
	if SposY + self.speed > winHeight then
		self.dirction = 3
	end
end

return SnakeBean























