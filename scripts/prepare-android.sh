#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
npm install
[ -d android ] || npx cap add android
# Versiya
G=android/app/build.gradle
sed -i 's/versionCode [0-9]*/versionCode 12/; s/versionName "[^"]*"/versionName "1.2.0"/' "$G"
# Mikrofon ruxsati
M=android/app/src/main/AndroidManifest.xml
grep -q RECORD_AUDIO "$M" || sed -i 's#<application#<uses-permission android:name="android.permission.RECORD_AUDIO" />\n    <application#' "$M"
npx cap sync android
echo "---- targetSdkVersion (Google talabi bilan solishtiring) ----"
grep -rn "targetSdkVersion" android/variables.gradle || true
