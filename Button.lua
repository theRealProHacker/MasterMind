Button=Class{}
function Button:init(text,code,x,y,width,height,textcolor,bgcolor,rounded,borderColor)
    if code then
        self.onclick=code
    end
    self.text=text or "Test"
    self.x=x or 0
    self.y=y or 0
    self.width=width or 200
    self.height=height or 100
    self.rounded=rounded or 0
    self.tc=textcolor or {0,0,0,1}
    self.col=bgcolor or TRANSPARENT
    self.borderColor=borderColor or TRANSPARENT
end

function Button:onclick()
    print("Button ".. self.text .. " was clicked")
end

function Button:draw()
    love.graphics.setColor(self.col)
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height,self.rounded)
    love.graphics.setColor(self.borderColor)
    love.graphics.rectangle("line",self.x,self.y,self.width,self.height,self.rounded)
    love.graphics.setColor(self.tc)
    --center text on y axis as well as x axis 
    love.graphics.setFont(mainFont)
    local fontheight = mainFont:getHeight()
    local y=centerY(fontheight,self.height,self.y)
    love.graphics.printf(self.text,self.x,y,self.width,"center")
    love.graphics.setColor(1,1,1,1)
end

function Button:update()
    local mouse=love.mouse
    local x,y=mouse.getPosition()
    if mouse.buttonsReleased[1] and inRectangle(x,y,self.x,self.y,self.width,self.height) then
        self:onclick()
    end
end

