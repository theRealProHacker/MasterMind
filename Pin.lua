Pin = Class{}

function Pin:init(number,x,y)
    self.x=x
    self.y=y
    self.selected=false
    self.image=images[types[number]]
    self.w,self.h=self.image:getDimensions()
    self.scale=playing.pinscale
    self.r=(self.w/2)*self.scale
end
function Pin:moveTo(x,y)
    self.x=x
    self.y=y
end
function Pin:draw()
    local scale=1/2
    local r=self.r
    love.graphics.draw(self.image,self.x-r,self.y-r,0,scale)
    if self.selected then
        love.graphics.setColor(WHITE)
        love.graphics.circle("line",self.x,self.y,r)
    end
end