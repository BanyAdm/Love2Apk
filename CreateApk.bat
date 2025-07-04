"Tools\apktool_2.11.1.jar" d -s -o love-decoded "Tools\love-11.5-android-embed.apk"
move game.love love-decoded/assets
cd love-decoded
cd assets
del /q dexopt
rmdir /s /q dexopt
cd..
cd..
"Tools\apktool_2.11.1.jar" b -o game.apk "love-decoded"
del /q love-decoded
rmdir /s /q love-decoded
"Tools\uber-apk-signer-1.3.0.jar" -a "game.apk"
del game.apk
del game-aligned-debugSigned.apk.idsig