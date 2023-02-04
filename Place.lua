Place=Class{}

function Place:init(number,x,y)
    self.number=number
    self.filled=false
    self.Pin=nil
    self.x=x
    self.y=y
    self.r=30
end

function Place:draw()
    if not self.filled then
        love.graphics.setColor({0.7,0.7,0.7,1})
        love.graphics.circle("fill",self.x,self.y,self.r)
        love.graphics.setColor({0.5,0.5,0.5,1})
        love.graphics.circle("line",self.x,self.y,self.r)
    else
        love.graphics.setColor(WHITE)
        self.pin:draw()
    end
end

function Place:fill(number)
    self.filled=number
    self.pin=Pin(number,self.x,self.y)
end