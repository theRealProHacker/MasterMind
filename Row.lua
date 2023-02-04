Row = Class{}

function Row:init(number,y)
    self.number=number
    self.y=y
    self.places={}
    self.finished=false
    self.corrections={}
    self.count={}
    for i=1,DIGITS do
        local x=100*i+300
        self.places[i]=Place(i,x,self.y)
    end
end

function Row:draw()
    for k,v in pairs(self.places) do
        v:draw()
    end
    if self.finished then
        -- draw the corrections
        if DIFFICULTY=="easy" then
            local colors={ --red,orange,green
                {1,0,0,1},
                {1,165/255,0},
                {0,1,0,1}
            }
            for k,v in pairs(self.corrections) do
                love.graphics.setColor(colors[v])
                local p=self.places[k]
                love.graphics.circle("fill",p.x,p.y,p.r-8)
            end
        else
            -- hard and medium difficulty
            local colors={
                falsch=TRANSPARENT,
                stelle=WHITE,
                richtig=BLACK}
            local x=1000
            local r=20
            if self.count then
                for k,v in pairs(self.count) do
                    print(k)
                    for i=1,v do
                        love.graphics.setColor(colors[k])
                        x=x-2.5*r
                        love.graphics.circle("fill",x,self.y,r)
                    end
                end
            end
        end
    end
    love.graphics.setColor(WHITE)
end

function Row:update()
    --check if all pins are filled
    local finished=true
    for k,v in pairs(self.places) do
        if not v.filled then
            finished=false
        end
    end
    if finished then
        self.finished=true
        --make corrections
        local count={
            falsch=0,
            stelle=0,
            richtig=0
        }
        for k,v in pairs(self.places) do
            local c
            if v.filled==playing.code[k] then
                c=3 -- correct -> green
                count.richtig=count.richtig+1
            elseif has_value(playing.code,v.filled) then
                c=2 -- the color is in the code but not at that position -> yellow 
                count.stelle=count.stelle+1
            else
                c=1 -- the color is not in the code -> red
                count.falsch=count.falsch+1
            end
            print("For place",v.number,":",c)
            self.corrections[k]=c
        end
        playing.won=count.richtig==DIGITS
        self.count=count
    end
end

