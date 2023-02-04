menu = {}

function menu:init()
    --Button(text,x,y,width,height,textcolor,bgcolor,rounded,code)
    local width,height=300,60
    --center Buttons
    local x,y=screenCenterPos(width,height)
    self.buttons={
        easy=Button("Easy",function () DIFFICULTY="easy";GS.switch(playing) end,x,y,width,height,{0,0,0,1},{1,1,1,1},10),
        medium=Button("Medium",function () DIFFICULTY="medium";GS.switch(playing) end,x,y+height*1.5,width,height,BLACK,WHITE),
        quit=Button("Quit Game",function () love.event.quit() end,x,y+height*3,width,height,BLACK,WHITE,5)
    }   
end

function menu:update(dt)
    for k,v in pairs(self.buttons) do
        v:update()
    end
end

function menu:draw()
    for k,v in pairs(self.buttons) do 
        v:draw()
    end
end