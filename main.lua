--Project setup in VScode Press alt+L to start up the game

-- TODO  pong-5 of GD50

local push = require 'push'


--Main window size
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


--this funciton is called at the beginning 
function love.load()
    love.window.setTitle('Pong! by craduzz with Love...2D')

    love.graphics.setDefaultFilter("nearest","nearest")

    --setup a random number
    math.randomseed(os.time())

    -- set new font
    smallFont = love.graphics.newFont('font.ttf',8)

    scoreFont = love.graphics.newFont('font.ttf', 32)


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    --player score and bar locations
    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    -- ball location and velocity

    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2
    
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)


    gamestate = 'start'
end

--function called constantly to update the state of the game and recives delta time as its parameter
function love.update(dt)

    -- [player 1 movement]
    -- p1 up
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)

    -- p1 down
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20,player1Y + PADDLE_SPEED * dt)
    end

    -- [player 2 movement]
    -- p2 up
    if love.keyboard.isDown('up') then
        player2Y = math.max(0,player2Y + -PADDLE_SPEED * dt)

    -- p2 down
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20,player2Y + PADDLE_SPEED * dt)
    end

    if gamestate == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

 
--this function is called whenever any key is pressed and passes the key pressed as its value
function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    
    
    elseif key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        else
            gamestate = 'start'

            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT /2 - 2


            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50,50) * 1.5
        end
    end

end

-- this function renders whatever is inside 
function love.draw()
    -- command to begin rendering at virtual resolution
    push:apply('start')

    -- fill the screen with a color
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.setFont(smallFont)
    love.graphics.printf(
        'Pong!',
        0,
        20,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH/ 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle("fill", 10, player1Y, 5, 20)

    love.graphics.rectangle("fill",VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    love.graphics.rectangle("fill", ballX, ballY, 4, 4)


    -- command to end rendering at virtual resolution
    push:apply('end')
end
