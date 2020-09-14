# Funding Choices

A wrapper for Google's Mobile Ads Consent SDK, i.e. used as GDPR dialog on Android and iOS. The IOS version is still under development.

## Usage
First of all set up your account at [Google Funding Choices](https://fundingchoices.google.com/) and activate SDK for your App.


To use this plugin, add `funding_choices` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
import 'package:funding_choices/funding_choices.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      FundingChoices();
      ...
```

You can use ```FundingChoices(true)``` for under age consent.

## Installation
Add this to your package's pubspec.yaml file:
``` yml
dependencies:
    funding_choices: ^0.5.2
```

Install the packages
``` bash
flutter pub get
```

Edit your ```app/build.gradle```
``` gradle
android {
    compileSdkVersion 28
    ...
    defaultConfig {
        ...
        minSdkVersion 28
        targetSdkVersion 28
        ...
```
Edit you ```AndroidManifeft.xml```
``` xml
   <application
       ...
       >
       <meta-data
           android:name="com.google.android.gms.ads.APPLICATION_ID"
           android:value="Publisher-ID"/>
       <activity android:name=".MainActivity"
       ...
```
### Publisher ID
Your publisher ID is the unique identifier for your AdMob account. [Find your publisher ID](https://support.google.com/admob/answer/2784578). It should look like this ```ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX```.
