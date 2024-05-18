push = require 'push'

windowWidth = 1280
windowHeight = 720

virtualWidth = 432 
virtualHeight = 243


paddleSpeed = 200
function love.load()
    love.graphics.setDefaultFilter('nearest', "nearest")

    tinyFont = love.graphics.newFont('font.ttf', 8)

    bigboiFont = love.graphics.newFont('font.ttf', 32)

    math.randomseed(os.time())

    love.graphics.setFont(tinyFont)

    push:setupScreen(virtualWidth, virtualHeight, windowWidth, windowHeight, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0 
    player2Score = 0

    player1Yaxis = 30
    player2Yaxis = virtualHeight - 50

    ballX = virtualWidth / 2 - 2
    ballY = virtualHeight / 2 - 2

    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    gameState = 'start'
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        player1Yaxis = math.max(0, player1Yaxis + -paddleSpeed * dt)
    elseif love.keyboard.isDown("s") then
        player1Yaxis = math.min(virtualHeight - 20, player1Yaxis + paddleSpeed * dt)
    end
    if love.keyboard.isDown("up") then
        player2Yaxis = math.max(0, player2Yaxis + -paddleSpeed * dt)
    elseif love.keyboard.isDown("down") then
        player2Yaxis = math.min(virtualHeight - 20, player2Yaxis + paddleSpeed * dt)
    end
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else    
            gameState = 'start'

            ballX = virtualWidth / 2 - 2
            ballY = virtualHeight / 2 - 2

            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(50, -50) * 1.5
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.setFont(tinyFont)
    love.graphics.printf('pong go brrrr', 0, 20, virtualWidth, 'center')

    love.graphics.setFont(bigboiFont)
    love.graphics.print(tostring(player1Score), virtualWidth / 2 - 50, virtualHeight / 3)
    love.graphics.print(tostring(player2Score), virtualWidth / 2 + 30, virtualHeight / 3)
 
    love.graphics.rectangle("fill", 10, player1Yaxis, 5, 20)

    love.graphics.rectangle("fill", virtualWidth - 10, player2Yaxis, 5, 20)

    love.graphics.rectangle("fill", ballX, ballY, 4, 4)

    push:apply('end')
end