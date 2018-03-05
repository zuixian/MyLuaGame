local ChangeBgScreen = Class("ChangeBgScreen")


dir = love.filesystem.getSource()
str = dir.."/res/bg/"
str1 = dir.."/res/bg/xiao/"
function ChangeBgScreen:init(game,bg)
	self.game = game
	self.bg = bg
	self.winWidth = love.graphics.getWidth()
	self.dir = "res/bg/xiao"
	self.files = love.filesystem.getDirectoryItems(self.dir)
	self.back = love.graphics.newImage("res/back.png")
	self.imgs = {}
	table.insert(self.imgs,love.graphics.newImage("res/xiangji.png"))
	for k, file in ipairs(self.files) do
		img = love.graphics.newImage(self.dir.."/"..file)
		table.insert(self.imgs,img)
	end
end

function ChangeBgScreen:draw()
	self:useTTFFont("更换背景",self.winWidth/2-70,90,36)
	local j = 0
	for i=1,#self.imgs do
		if i%6==0 then
			j = j + 1
		end
		love.graphics.draw(self.imgs[i],150+120*((i%6)+1),200+120*j)
	end
	love.graphics.draw(self.back,20,20)
end

function ChangeBgScreen:getRandomNum(x,y)
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))
	return math.random(x,y)
end

function ChangeBgScreen:update(dt)

end

function ChangeBgScreen:keypressed(key)
	
end

function ChangeBgScreen:mousepressed(x,y,button,istouch)
	local j = 0
	for i = 1,#self.imgs do
		if i%6==0 then
			j = j + 1
		end
		if x > 150+120*((i%6)+1) and x < 250+120*((i%6)+1) and y > 200+120*j and y < 300+120*j then
			if i == 1 then
				str = str.."bg"..tostring(#self.imgs-1)..".png"
				str1 = str1.."bg"..tostring(#self.imgs-1)..".png"
				myLualib.openCamera()
				self.files = love.filesystem.getDirectoryItems(self.dir)
				table.insert(self.imgs,love.graphics.newImage(self.dir.."/bg"..tostring(#self.imgs-1)..".png"))
			elseif i == 2 then
				self.bg:setBg("bg.png")
			elseif i <= #self.imgs then
				self.bg:setBg("bg"..tostring(i-2)..".png")
			end
		end
	end
	if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
	end
	
	if x > 70 and x < 170 and y > 120 and y < 170 then
		myLualib.takePohot()
	end
end

function ChangeBgScreen:touchmoved( id, x, y, dx, dy, pressure )
	
end

function ChangeBgScreen:touchpressed( id, x, y, dx, dy, pressure )
	if x > 20 and x < 70 and y > 20 and y < 70 then
			self.game.state = "home"
	end
end

local isInit=true
function ChangeBgScreen:useTTFFont(text,x,y,size)
	if isInit then
		local font=love.graphics.newFont("font/cn.ttf",size)
		love.graphics.setFont(font)
		isInit = false
	end
    love.graphics.print(text,x,y)
end

return ChangeBgScreen