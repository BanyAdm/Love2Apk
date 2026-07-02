#!/bin/bash
set -e
trap 'rm -rf "$DECODED_DIR" "$APK_OUT"' EXIT

SCRIPT_DIR=$(pwd)
DECODED_DIR="$SCRIPT_DIR/love-decoded"
ASSETS_DIR="$DECODED_DIR/assets"
APKTOOL_JAR="$SCRIPT_DIR/Tools/apktool_termux.jar"
EMBED_APK="$SCRIPT_DIR/Tools/love-11.5-android-embed.apk"
UBER_SIGNER="$SCRIPT_DIR/Tools/uber-apk-signer-1.3.0.jar"
DEFAULT_ICON="$SCRIPT_DIR/defaults/default_icon.png"

echo "===== LOVE APK Builder ====="

# --- Prompt user ---
read -p "Enter APK Name [MyGame]: " APK_NAME
APK_NAME=${APK_NAME:-MyGame}

read -p "Enter Package Name [com.example.mygame]: " PACKAGE_NAME
PACKAGE_NAME=${PACKAGE_NAME:-com.example.mygame}

read -p "Enter path to .love file: " LOVE_FILE
if [ ! -f "$LOVE_FILE" ]; then
    echo "ERROR: .love file not found!"
    exit 1
fi

read -p "Enter path to icon (press Enter to use default): " ICON_FILE
ICON_FILE=${ICON_FILE:-$DEFAULT_ICON}
if [ ! -f "$ICON_FILE" ]; then
    echo "Icon file not found! Using default."
    ICON_FILE=$DEFAULT_ICON
fi

echo "Select orientation:"
echo "1) Portrait"
echo "2) Landscape"
read -p "Choice [1]: " ORIENT_CHOICE
ORIENT_CHOICE=${ORIENT_CHOICE:-1}
if [ "$ORIENT_CHOICE" = "1" ]; then ORIENTATION="portrait"; else ORIENTATION="landscape"; fi

APK_OUT="$SCRIPT_DIR/${APK_NAME}.apk"
SIGNED_APK="${APK_OUT%.apk}-aligned-debugSigned.apk"

# --- Progress function ---
progress() {
    PERCENT=$1
    STEP=$2
    echo -ne "[$PERCENT%] $STEP\r"
}

echo
progress 0 "Starting build..."

# --- Decode APK ---
progress 10 "Decoding APK..."
java -jar "$APKTOOL_JAR" d -s -o "$DECODED_DIR" "$EMBED_APK"
# --- Remove dexopt folder ---
progress 30 "Removing dexopt folder..."
rm -rf "$ASSETS_DIR/dexopt"

# --- Copy LOVE file ---
progress 40 "Copying .love file..."
mkdir -p "$ASSETS_DIR"
cp "$LOVE_FILE" "$ASSETS_DIR/game.love"

# --- Copy icon ---
progress 50 "Copying icon..."
mkdir -p "$DECODED_DIR/res/drawable"
cp "$ICON_FILE" "$DECODED_DIR/res/drawable/ic_launcher.png"

# --- Rewrite AndroidManifest.xml ---
progress 60 "Writing AndroidManifest.xml..."
MANIFEST_FILE="$DECODED_DIR/AndroidManifest.xml"
cat > "$MANIFEST_FILE" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android" android:compileSdkVersion="34" android:compileSdkVersionCodename="14" package="$PACKAGE_NAME" platformBuildVersionCode="34" platformBuildVersionName="14">
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.VIBRATE"/>
    <uses-permission android:name="android.permission.BLUETOOTH"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO"/>
    <uses-permission android:maxSdkVersion="18" android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-feature android:glEsVersion="0x00020000"/>
    <uses-feature android:name="android.hardware.touchscreen" android:required="false"/>
    <uses-feature android:name="android.hardware.bluetooth" android:required="false"/>
    <uses-feature android:name="android.hardware.gamepad" android:required="false"/>
    <uses-feature android:name="android.hardware.usb.host" android:required="false"/>
    <uses-feature android:name="android.hardware.type.pc" android:required="false"/>
    <uses-feature android:name="android.hardware.audio.low_latency" android:required="false"/>
    <uses-feature android:name="android.hardware.audio.pro" android:required="false"/>
    <permission android:name="$PACKAGE_NAME.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION" android:protectionLevel="signature"/>
    <uses-permission android:name="$PACKAGE_NAME.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION"/>
    <application android:allowBackup="true" android:appComponentFactory="androidx.core.app.CoreComponentFactory" android:extractNativeLibs="true" android:icon="@drawable/ic_launcher" android:label="$APK_NAME" android:usesCleartextTraffic="true">
        <activity android:configChanges="keyboard|keyboardHidden|navigation|orientation|screenLayout|screenSize|smallestScreenSize" android:exported="true" android:label="$APK_NAME" android:launchMode="singleInstance" android:name="org.love2d.android.GameActivity" android:resizeableActivity="false" android:screenOrientation="$ORIENTATION" android:theme="@android:style/Theme.NoTitleBar.Fullscreen">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
                <category android:name="tv.ouya.intent.category.GAME"/>
            </intent-filter>
            <intent-filter>
                <action android:name="android.hardware.usb.action.USB_DEVICE_ATTACHED"/>
            </intent-filter>
        </activity>
        <provider android:authorities="$PACKAGE_NAME.androidx-startup" android:exported="false" android:name="androidx.startup.InitializationProvider">
            <meta-data android:name="androidx.emoji2.text.EmojiCompatInitializer" android:value="androidx.startup"/>
            <meta-data android:name="androidx.lifecycle.ProcessLifecycleInitializer" android:value="androidx.startup"/>
        </provider>
        <meta-data android:name="com.android.dynamic.apk.fused.modules" android:value="base"/>
        <meta-data android:name="com.android.vending.splits" android:resource="@xml/splits0"/>
    </application>
</manifest>
EOF

# --- Build APK ---
progress 70 "Building APK..."
java -jar "$APKTOOL_JAR" b --use-aapt2 -o "$APK_OUT" "$DECODED_DIR"

# --- Sign APK ---
progress 90 "Signing APK..."
java -jar "$UBER_SIGNER" -a "$APK_OUT"

# --- Cleanup ---
progress 100 "Cleaning up..."
rm -rf "$DECODED_DIR"
rm -f "$APK_OUT"
rm -f "${SIGNED_APK}.idsig"

echo
echo "✅ Build completed! Signed APK: $SIGNED_APK"
