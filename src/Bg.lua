local Bg = Class("Bg")

function Bg:init()
	self.url = "res/bg/"
	self.imgUrl = "bg.png"
	self.img = love.graphics.newImage(self.url..self.imgUrl)
end

function Bg:draw()
	love.graphics.draw(self.img,0,0)
end

function Bg:setBg(imgUrl)
	self.img = love.graphics.newImage(self.url..imgUrl)
end

return Bg