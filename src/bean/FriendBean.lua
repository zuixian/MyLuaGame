local FriendBean=Class("FriendBean")

function FriendBean:init()
	self.img = love.graphics.newImage("res/Friend.png")
	self.width = self.img:getWidth()
	self.height = self.img:getHeight()
	self.posX = love.graphics.getWidth()/2
	self.posY = love.graphics.getHeight()/2
	self.range = self.width/2
	self.hp = 5
end

function FriendBean:paint()
	love.graphics.draw(self.img,self.posX,self.posY,0,1,1,self.width/2,self.height/2)
end

function FriendBean:check(enemys)
	local i = 1
	while i < #enemys do
        if self:isBZ(enemys[i])
		then
			if enemys[i].id == 3 then
				self.hp = self.hp + 1
			else
				self.hp = self.hp - 1
			end
            table.remove(enemys,i)
        else
            i = i + 1
        end
    end
end

function FriendBean:isBZ(enemy)
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

return FriendBean