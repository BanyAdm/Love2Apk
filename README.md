# Löve2Apk❤➡🤖

Its A New Tool To Turn Love2d Files (.love) To Android Files (.apk). ↕

It Supports The Latest Version Of Löve2d (11.5)❤

# Current Platforms
- Windows
- Linux

# Requirements⚙️

- java
    - Windows `Windows Online` on [Java site](https://www.java.com/en/download/manual.jsp)
    - Linux `default-jre` in your package manager.

# Instruction🛠

**1.** Select Every File Inside Your Game Folder

**2.** Compress It to a Zip File Using **Winrar** Or Any Zip Tool

**3.** Rename The Compressed Version Of the Folder to **"game.love"**

**4.** Put The **game.love** File Inside **Love2Apk** Folder

**5.** Open the **builder.exe**, or if your using linux then open the terminal in the same directory and run
`./builder.sh`, then go through the options.

**6.** Once the build Finishes, You Should See A File Called **"(your apk name)-aligned-debugSigned.apk"** Thats Your Apk File

# Info
The Playstore may flag your apk as an "unknown" app, and thats because your apk package name isnt recognized in the Playstore
Thats completely fine, and that doesnt mean that this software is a malware of some sort

also the game might not be rotated to portrait because love2d automatically makes the game landscape
to fix this you have to add this logic

```lua
local orientation = "portrait" --or landscape

function love.load()
    ScreenW, ScreenH = love.graphics.getDimensions()

    if orientation == "portrait" then
        love.window.setMode(ScreenH, ScreenW)
    else
        love.window.setMode(ScreenW, ScreenH)
    end
end
```

**Thänks!** ❤
