local SnakeTail=Class("SnakeTail")


function SnakeTail:init(x,y,d)
	self.posX = x
	self.posY = y
	self.dirction = d
	self.img = love.graphics.newImage("res/snakeTail.png")
	self.width = self.img:getWidth()
	self.height = self.img:getHeight()
end

function SnakeTail:getPos()
	return self.posX,self.posY,self.dirction
end

function SnakeTail:setPos(x,y,d)
	self.posX = x
	self.posY = y
	self.dirction = d
end

function SnakeTail:paint()
	love.graphics.draw(self.img,self.posX,self.posY,math.rad(self.dirction),1,1,self.width/2,self.height/2)
end

function SnakeTail:getPos()
	return self.posX,self.posY,self.dirction
end

return SnakeTail