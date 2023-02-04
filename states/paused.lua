paused={}

function paused:init()
    local w=200
    local h=40
    local x=screenCenterX(w)
    local y=300
    local r=10
    self.buttons={
        quit=Button("Quit Game",love.event.quit,x,y,w,h,BLACK,WHITE,r),
        resume=Button("Resume",function() GS.pop() end,x,y+1.5*h,w,h,BLACK,WHITE,r),
        mainMenu=Button("Main Menu",function() 
            self.from:leave(menu)
            GS.switch(menu) 
        end,x,y+3*h,w,h,BLACK,WHITE,r)
    }
    local createPauseScreen = function()
        local width=400
        local height=400
        local x,y=screenCenterPos(width,height)
        local color={0,0.5,1,1}
        return {x=x,y=y,w=width,h=height,c=color}
    end
    self.pauseScreen=createPauseScreen()
end

function paused:enter(from)
    self.from=from
end

function paused:update()
    for k,v in pairs(self.buttons) do
        v:update()
    end
end

function paused:draw()
    if self.from==playing then
        self.from:draw()
    end
    --draw backdrop
    love.graphics.setColor({0,0,0,0.4})
    love.graphics.rectangle("fill",0,0,love.graphics.getDimensions())
    love.graphics.setColor(WHITE)
    self:__draw_pause_screen__()
    for k,v in pairs(self.buttons) do
        v:draw()
    end
end

function paused:mousereleased(x,y,button,istouch,presses)
    local mx,my = love.mouse.getPosition()
    local s=self.pauseScreen
    if button==1 and not inRectangle(mx,my,s.x,s.y,s.w,s.h) then
        GS:pop()
    end
end

function paused:__draw_pause_screen__()
    local s=self.pauseScreen
    love.graphics.setColor(s.c)
    love.graphics.rectangle("fill",s.x,s.y,s.w,s.h)
    love.graphics.setColor(BLACK)
    love.graphics.setFont(capitalFont)
    love.graphics.printf("Paused",s.x,s.y+20,s.w,"center")
end