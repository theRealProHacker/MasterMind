
function screenCenterX(width)
    local screenwidth=love.graphics.getWidth()
    return (screenwidth-width)/2
end
function screenCenterY(height)
    local screenheight=love.graphics.getHeight()
    return (screenheight-height)/2
end
function screenCenterPos(width,height)
    local x=screenCenterX(width)
    local y=screenCenterY(height)
    return x,y
end
function centerY(height,fullHeight,yOffset)
    local yOffset=yOffset or 0
    local y=(fullHeight-height)/2 + yOffset
    return y
end
function centerInRect(width,height,rectHeight,rectWidth,rectX,rectY)
    local rectX=rectX or 0
    local rectY=rectY or 0
    local x=(rectWidth-width)/2 + rectX
    local y=(rectHeight-height)/2 + rectY
    return x,y
end
function inRectangle(x,y,rectX,rectY,width,height)
    return x>=rectX and x<=rectX+width and y>=rectY and y<=rectY+height
end
function inCircle(x,y,cX,cY,r)
    return (cX-x)^2+(cY-y)^2<=r^2
end
function createRandomCode(digits,maxDigit)
    local code = {}
    for i=1,digits,1 do
        code[i]=math.ceil(math.random()*(maxDigit))
    end
    return code
end
function has_value (tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end
function distance(x1,y1,x2,y2)
    x1=math.abs(x1) or 0
    y1=math.abs(y1) or 0
    x2=math.abs(x2) or 0
    y2=math.abs(y2) or 0
    local distance = math.sqrt((x1-x2)^2+(y1-y2)^2)
    return distance
end
function displayCenter(string)
    string=string or ""
    love.graphics.setFont(scoreFont)
    love.graphics.setColor(0,0,0,1)
    local width,height = love.graphics.getDimensions()
    love.graphics.print(string,width/2-10 , height/2-10)
    love.graphics.setColor(1,1,1,1)
end
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(largeFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1,1,1,1)
end
function displayMemory()
    -- simple Memory display
    love.graphics.setFont(largeFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('Memory: ' .. tostring(round(collectgarbage("count"))), 10, 30)
    love.graphics.setColor(1,1,1,1)
end