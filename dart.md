# How to install dart from sources on linux
More info [here](https://github.com/dart-lang/sdk/wiki/Building)
```bash
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH="$PATH:$PWD/depot_tools
mkdir dart-sdk
cd dart-sdk
fetch dart
cd sdk
./tools/build.py --mode release --arch x64 create_sdk
```

# Flutter
More info [here](https://flutter.dev/docs/get-started/install/linux)
```
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

flutter precache
Dart SDK is downloaded into:
flutter/bin/cache/dart-sdk

flutter upgrade

flutter doctor

flutter config --no-analytics
```

# Android stuio
```
Download from 
https://developer.android.com/studio

tar xvzf ...

mv android-studio ~/bin/
~/bin/android-studio/bin/studio.sh

Download to:
$HOME/Android/Sdk

Configure VM acceleration on Linux:
https://developer.android.com/studio/run/emulator-acceleration?utm_source=android-studio#vm-linux
```

# Run tests commandline 
[more](https://pub.dev/packages/test)
```
pub run test test/ifdb_client_test.dart -n "IFDB MySQL Data"
```
