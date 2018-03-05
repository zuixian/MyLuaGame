local HelpScreen = Class("HelpScreen")

function HelpScreen:init(game)
	self.game = game
	self.help = love.graphics.newImage("res/helptext.png")
	self.back = love.graphics.newImage("res/back.png")
	self.width = self.help:getWidth()
	self.height = self.help:getHeight()
	self.winWidth = love.graphics.getWidth()
	self.winHeight = love.graphics.getHeight()
end

function HelpScreen:draw()
	love.graphics.draw(self.help,self.winWidth/2,self.winHeight/2,0,1,1,self.width/2,self.height/2)
	love.graphics.draw(self.back,20,20)
end

function HelpScreen:update(dt)

end

function HelpScreen:keypressed(key)
	if key == "appback" then
		self.game.state = "home"
	end
end

function HelpScreen:mousepressed(x,y,button,istouch)
	if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
		end
end

function HelpScreen:touchmoved( id, x, y, dx, dy, pressure )

end

function HelpScreen:touchpressed( id, x, y, dx, dy, pressure )
	if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
		end
end

return HelpScreen


