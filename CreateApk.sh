#!/bin/bash
set -e

java -jar Tools/apktool_2.11.1.jar d -s -o love-decoded Tools/love-11.5-android-embed.apk
mv game.love love-decoded/assets
rm -rf love-decoded/assets/dexopt
java -jar Tools/apktool_2.11.1.jar b -o game.apk love-decoded
rm -rf love-decoded
java -jar Tools/uber-apk-signer-1.3.0.jar -a game.apk
rm -f game.apk
rm -f game-aligned-debugSigned.apk.idsig