![love2apk_icon](/defaults/default_icon.png)

![GitHub stars](https://img.shields.io/github/stars/banyadm/love2apk?style=for-the-badge) 
![GitHub License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

### NOTICE ⚠️
---
As of Google's new September update, it changes how apk installations, and building work
the repository would not possibly work due to the signing step needing a private key which you can only get by verifying your government id and paying a 25$ fee

so enjoy this tool while it lasts, if this updates rolls out completely, there is a high chance this repository will be archived or just not work

thank you guys for using this tool
---

# Löve2Apk❤➡🤖

Its A Tool To Turn Love2d Files (.love) To Android Files (.apk). ↕

It Supports The Latest Version Of Löve2d (11.5)❤

# Current Platforms
- Windows
- Linux
- Termux

# Requirements⚙️

- java
    - Windows `Windows Online` on [Java site](https://www.java.com/en/download/manual.jsp)
    - Linux `default-jre` in your package manager.
    - Termux, Run `pkg install openjdk-17`
      

# Instruction🛠

**1.** Select Every File Inside Your Game Folder

**2.** Compress It to a Zip File Using **Winrar** Or Any Zip Tool

**3.** Rename The Compressed Version Of the Folder to **"game.love"**

**4.** Put The **game.love** File Inside **Love2Apk** Folder

**5.** Open The builder, follow the tutorial that depends on your operating system

[Windows Tutorial](/Docs/windows-tutorial.md)
[Linux Tutorial](/Docs/linux-tutorial.md)
[Termux Tutorial](/Docs/termux-tutorial.md)

APK Name: the title/name of your game

Package Name: basically an id, every app has its own Package Name, you gotta use a format like this

`com.COMPANY.APPNAME`

App Icon: just drag a `PNG` icon into the text box or put the location of it

LOVE File: you gotta zip your game into a `.love` file and drag it there

Orientation: portrait or landscape

**6.** Once the build Finishes, You Should See A File Called **"(your apk name)-aligned-debugSigned.apk"** Thats Your Apk File

# Info
The Playstore may flag your apk as an "unknown" app, and thats because your apk package name isnt recognized in the Playstore
Thats completely fine, and that doesnt mean that this software is a malware of some sort

also the game might not be rotated to portrait because love2d automatically makes the game landscape
to fix this you have to add this [conf.lua](/Docs/conf.lua) file in your game folder


**Thänks!** ❤
