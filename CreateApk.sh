java -jar "./Tools/apktool_2.11.1.jar" d -s -o love-decoded "./Tools/love-11.5-android-embed.apk"
cp AndroidManifest.xml love-decoded
mv game.love love-decoded/assets
cd love-decoded
cd assets
rm dexopt
rm -rf dexopt/
cd ..
cd ..
java -jar "./Tools/apktool_2.11.1.jar" b -o game.apk "love-decoded"
rm love-decoded
rm -rf love-decoded/
java -jar "./Tools/uber-apk-signer-1.3.0.jar" -a "game.apk"
rm game.apk
rm game-aligned-debugSigned.apk.idsig
