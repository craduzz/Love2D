--Project setup in VScode Press alt+L to start up the game


--Main window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

function love.draw()
    love.graphics.printf(
        'Hello Pong! this is a string test',
        0,
        WINDOW_HEIGHT/2-6,
        WINDOW_WIDTH,
        'center'
    )
end


