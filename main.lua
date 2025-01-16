function love.load()
    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1 -- variavel para organizar os estados do jogo
    -- 1 = main menu
    -- 2 = gameplay

    gameFont = love.graphics.newFont(40)

    sprites = {} -- sprites table
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')




end

function love.update(dt) -- funçao que é verificada frame a frame (roda a 60 fps por padrão)

    if timer > 0 then
        timer = timer - dt 
    end
    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()
   
    love.graphics.draw(sprites.sky, 0, 0)


    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: ".. score, 0, 5) -- O .. é a concatenação na Lua
    love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, 250, love.graphics.getWidth(),"center") -- Imprimir um texto na tela de forma centralizada
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end

    love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20) --love.mouse.getX e getY pega o valor do ponteiro do mouse na tela
    love.mouse.setVisible(false)

    


end

function love.mousepressed(x, y, button, isTouch, pressed) --Funçao para inputs de mouse

        if  button == 1 and gameState == 2 then
            local mouseToTarget = distanceBetween(x,y, target.x, target.y)
            if mouseToTarget < target.radius then
                score = score + 1
                target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
                target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
            end
        elseif button == 1 and gameState == 1 then
            gameState = 2
            timer = 10
            score = 0
        end
end

function distanceBetween(x1, y1, x2,y2) -- calcula a distancia entre o mouse e alvo
    return math.sqrt((x2-x1)^2 + (y2 - y1)^2) -- formula para calcular a distancia
end 