
# Sherpout mobile app

A brief description of what this project does and who it's for


## Used libraries

### flutter_native_splash

**Purpose:** Generate native splash screen for Android and IOS

**Usage:**

To change splash screen you need to edit splash.yml file.

To build splash screen you need to execute command:

```console
dart run flutter_native_splash:create --path=splash.yml
```

If you don't see changes, try this:

```console
flutter clean

flutter pub get
```

and then try to generate splash screen once again.


