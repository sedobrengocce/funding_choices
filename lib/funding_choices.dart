
import 'dart:async';

import 'package:flutter/services.dart';

class FundingChoices {
  static const MethodChannel _channel =
      const MethodChannel('funding_choices');

  // Create singltone class
  FundingChoices._();
  
  static FundingChoices _singleton;

  factory FundingChoices([bool tagForUnderAgeOfConsent]) {
    if(_singleton == null) {
      _singleton = FundingChoices._();
      _singleton._init(tagForUnderAgeOfConsent ?? false);
    }
    return _singleton;
  }

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<void> _init(bool tagForUnderAgeOfConsent) {
    return _channel.invokeMethod('init', {'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent});
  }
}
