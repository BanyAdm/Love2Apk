local Portrait = true

--^^^^^^^^^^^^^^^^
-- false : Landscape
-- true : Portrait
-- YOU HAVE TO PUT THE conf.lua FILE IN THE ROOT OF YOUR GAME FOLDER

function love.conf(t)
    if Portrait == true then
        t.window.height, t.window.width = t.window.width, t.window.height
    end
end
