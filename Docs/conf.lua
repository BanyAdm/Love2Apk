local Portrait = true

--^^^^^^^^^^^^^^^^
-- false : Landscape
-- true : Portrait

function love.conf(t)
    if Portrait == true then
        t.window.height, t.window.width = t.window.width, t.window.height
    end
end