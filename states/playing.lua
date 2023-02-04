playing={}

function playing:init()
    self.pinscale=0.5
    --buttons
    self.buttons={
        pause=Button("Pause",function () GS.push(paused);self.left=true end,20,50,200,40)
    }
end

function playing:enter(from)
    self.left=false
    self.won=false
    self.ending=false
    self.MAX_TRIES=MAX_TRIES[DIFFICULTY]
    --rows
    self.rows={}
    self.currentRow=self.MAX_TRIES
    local offset,scale
    if DIFFICULTY == "easy" then
        offset=50
        scale=100
    elseif DIFFICULTY == "medium" then
        offset=0
        scale=80
    end
    for i=1,self.MAX_TRIES do
        local y=i*scale+offset
        self.rows[i]=Row(i,y)
    end
    --pins
    self.pins={}
    for i=1,MAX_TYPES do
        local x=i*100+300
        local y=680
        self.pins[i]=Pin(i,x,y)
    end
    --create random code
    self.code=createRandomCode(MAX_TYPES,DIGITS) or {1,2,3,4}
    assert(#self.code==DIGITS) --redundant
    print("Code")
    for k,v in pairs(self.code) do 
        print(v)
    end
end

function playing:resume()
    self.left=false
end

function playing:leave()

end

function playing:update(dt)
    if self.won then
        if not self.ending then
            Timer.after(2,function () GS.switch(ended,"won",self.code) end)
            local canvas=love.graphics.newCanvas()
            canvas:renderTo(function ()
                    love.graphics.circle("fill",0,0,12)
            end)
            local sw,sh=love.graphics.getDimensions()
            self.pss=love.graphics.newParticleSystem(canvas,64)
            self.pss:setParticleLifetime(2)
            self.pss:setEmitterLifetime(2)
            self.pss:setSpread(math.pi/8)
            self.pss:setRadialAcceleration(50)
            self.pss:setSpeed(500,700)
            self.pss2=self.pss:clone()
            self.pss:setPosition(sw/2-100,sh-100)
            self.pss:setDirection( math.pi/2*3.5 )
            self.pss2:setPosition(sw/2+100,sh-100)
            self.pss2:setDirection( math.pi/2*2.5)
            self.pss:emit(64)
            self.pss2:emit(64)
            self.ending=true
        else
            self.pss:update(dt)
            self.pss2:update(dt)
        end
    else
        for k,v in pairs(self.buttons) do
            v:update()
        end
        local row=self.rows[self.currentRow]
        if not row.finished then
            row:update() 
        else
            self.currentRow=self.currentRow-1
            if DIFFICULTY=="easy" then
                local next=self.rows[self.currentRow]
                for k,v in pairs(row.corrections) do
                    if v==3 then
                        next.places[k]:fill(row.places[k].filled)
                    end
                end
            end
            if self.currentRow<1 then
                GS.switch(ended,"lost",self.code)
            end
        end
    end
end

function playing:draw()
    if not self.left then
        for k,v in pairs(self.buttons) do 
            v:draw()
        end
    end
    -- draw an arrow to indicate the current row
    local row=self.rows[self.currentRow]
    love.graphics.draw(images["green-arrow"],250,row.y+row.places[1].r,-math.pi/2,1/12)
    for k,v in pairs(self.rows) do
        v:draw()
    end
    for k,v in pairs(self.pins) do
        v:draw()
    end
    if self.ending then
        --draw firework
        local sw,sh=love.graphics.getDimensions()
        love.graphics.draw(self.pss,sw/2-400,sh-500)
        love.graphics.draw(self.pss2,sw/2+400,sh-500)
    end
end

function playing:mousereleased(x,y,button,istouch,pressed)
    -- check if mouse was clicked on a pin
    local selectedPin=false
    for k,v in pairs(self.pins) do
        if v.selected then
            selectedPin=k
        end
        --give the player a larger radius to click
        if inCircle(x,y,v.x,v.y,v.r+10) then
            --deselect all others
            for k,v in pairs(self.pins) do
                v.selected=false
            end
            v.selected=true
        end
    end
    --check if mouse was clicked on a place in the current row and a pin was selected before
    if selectedPin then
        for k,v in pairs(self.rows[self.currentRow].places) do
            --give the player a larger radius to click
            if inCircle(x,y,v.x,v.y,v.r+10) then
                v:fill(selectedPin)
                --self.pins[selectedPin].selected=true
            end
        end
    end
end
