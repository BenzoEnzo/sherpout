
# Sherpout mobile app

A brief description of what this project does and who it's for


## Used libraries

### flutter_native_splash

- **Purpose:** Generate native splash screen for Android and IOS


- **Usage:**

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

### flutter_localizations && intl

- **Purpose:** Add internationalization of text values in the app


- **Configuration:**

  To make internationalization work, you have to generate language files. They should be generated automatically, but if not, then the app will not be built. In this case you have to use command:

    ```console
    flutter gen-l10n
    ```
  
  Internationalization files are located i lib/l10n directory. The .arb files contain translations for text values, and the l10n.dart file contains list of available languages.


- **Usage:**

  To use translations you have to add:
  ```dart
  import 'package:flutter_gen/gen_l10n/app_localizations.dart';
  ```
  to the class you use. then you can use:
  ```dart
  AppLocalizations.of(context)!.transationName)
  ```
  in your component, where "translationName" is name form arb file.
  


