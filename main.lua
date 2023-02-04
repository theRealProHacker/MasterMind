require 'requires'
-- physical screen dimensions
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1080
VIRTUAL_HEIGHT = 720

--globals
WHITE={1,1,1,1}
BLACK={0,0,0,1}
TRANSPARENT={0,0,0,0}

MAX_TYPES=4
DIGITS=4
MAX_TRIES={ -- or how many rows
    easy=5,
    medium=7
}
DIFFICULTY="easy"
function love.load()
    assert(#types==MAX_TYPES)
    math.randomseed(os.time())
    love.window.setTitle('MasterMind')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    --love.graphics.setBackgroundColor(0.5,1,0.5,1)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
    love.window.maximize()
    -- initialize mouse input table
    love.mouse.buttonsReleased = {}
    --initialize gamestate and set to menu state
    GS.registerEvents()
    GS.switch(menu)
end
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
function love.mousereleased(x,y,button,istouch,presses)
    love.mouse.buttonsReleased[button]=true
end

function love.update(dt)
    Timer.update(dt)
end

function love.draw()
    local width,height=love.graphics.getDimensions()
    local bgwidth,bgheight=images["background"]:getDimensions()
    love.graphics.setColor(WHITE)
    love.graphics.draw(images["background"],0,0,0,width/bgwidth,height/bgheight)
    love.mouse.buttonsReleased = {}
    displayFPS()
    displayMemory()
end

function love.resize(w,h)
    push:resize(w,h)
end