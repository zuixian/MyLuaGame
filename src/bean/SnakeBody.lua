local SnakeBody=Class("SnakeBody")

function SnakeBody:init(x,y,d)
	self.posX = x
	self.posY = y
	self.dirction = d
	self.img = love.graphics.newImage("res/snakeBody.png")
	self.width = self.img:getWidth()
	self.height = self.img:getHeight()
	self.range = self.width/2
end


function SnakeBody:paint()
	love.graphics.draw(self.img,self.posX,self.posY,math.rad(self.dirction),1,1,self.width/2,self.height/2)
end

function SnakeBody:check(enemys)
	local i = 1
	while i < #enemys do
        if self:isBZ(enemys[i])
		then
            table.remove(enemys,i)
			return true
        else
            i = i + 1
        end
    end
	return false
end

function SnakeBody:isBZ(enemy)
	local x1 = enemy.posX
	local y1 = enemy.posY
	local range1 = enemy.width
	if ((math.abs(x1 - self.posX) < self.range) and (math.abs(y1 - self.posY) < self.range))
	or ((math.abs(x1 - self.posX) < range1) and (math.abs(y1 - self.posY) < range1))
	then
		return true
	else
		return false
	end
end

return SnakeBody