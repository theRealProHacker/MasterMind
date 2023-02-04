ended={}

function ended:init()
    local width,height=300,60
    local x,y=screenCenterPos(width,height)
    local r=10
    y=y+50 -- y-Offset
    self.buttons={
        menu=Button("Main Menu",function () GS.switch(menu) end,x,y,width,height,BLACK,WHITE,r),
        play=Button("Play Again",function () GS.switch(playing) end,x,y+1.5*height,width,height,BLACK,WHITE,r)
    }
end

function ended:update(dt)
    for k,v in pairs(self.buttons) do
        v:update()
    end
end

function ended:enter(from,state,code)
    self.state=state or "lost" --lost or won
    self.text="You " .. self.state
    self.code=code or {}
    self.pins={}
    local xOffset=-40
    for k,v in pairs(self.code) do
        local x=100*k+(love.graphics.getWidth()-100*DIGITS)/2+xOffset
        local y=350
        self.pins[k]=Pin(v,x,y)
    end
end

function ended:draw()
    -- draw a text, the code as Pins and some Buttons
    love.graphics.setFont(capitalFont)
    love.graphics.setColor(WHITE)
    love.graphics.printf(self.text,0,200,love.graphics.getWidth(),"center")
    for k,v in pairs(self.buttons) do
        v:draw()
    end
    for k,v in pairs(self.pins) do
        v:draw()
    end
end