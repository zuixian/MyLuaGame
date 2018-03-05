local EnemyBean=Class("EnemyBean")

function EnemyBean:init(addMaxSpeed)
	local winHeight = love.graphics.getHeight()
	local winWidth = love.graphics.getWidth()
	self.id = self:getRandomNum(1,5)
	self.img = love.graphics.newImage("res/"..tostring(self.id)..".png")
	self.width = self.img:getWidth()
	self.height = self.img:getHeight()
	self.maxSpeed = 40 + addMaxSpeed
	local isDir = self:getRandomNum(1,4)
	if isDir == 1 then
		self.posX = self:getRandomNum(-100,0)
		self.posY = self:getRandomNum(-10,winHeight+10)
	elseif isDir == 2 then
		self.posX = self:getRandomNum(-10,winWidth+10)
		self.posY = self:getRandomNum(-100,0)
	elseif isDir == 3 then
		self.posX = self:getRandomNum(winWidth,winWidth+100)
		self.posY = self:getRandomNum(-10,winHeight+10)
	elseif isDir == 4 then
		self.posX = self:getRandomNum(-10,winWidth+10)
		self.posY = self:getRandomNum(winHeight,winHeight+100)
	end
	self.speed = self:getRandomNum(5,self.maxSpeed)
end

function EnemyBean:draw()
	love.graphics.draw(self.img,self.posX,self.posY,0,1,1,self.width/2,self.height/2)
end

function EnemyBean:getRandomNum(x,y)
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	return math.random(x,y)
end

function EnemyBean:caluSpeed(x,y)
	local lengX = x - self.posX
	local lengY = y - self.posY
	local length = math.sqrt(lengX*lengX + lengY*lengY)
	local moveTime = length/self.speed
	x_speed = lengX/moveTime
	y_speed = lengY/moveTime
end

function EnemyBean:moveToTarget(x,y)
	self:caluSpeed(x,y)
	self.posX = self.posX + x_speed
	self.posY = self.posY + y_speed
end

return EnemyBean