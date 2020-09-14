import 'dart:async';

import 'package:flutter/services.dart';

/// Main Plugin Class
class FundingChoices {
  /// channel name
  static const MethodChannel _channel = const MethodChannel('funding_choices');

  /// Private constructor
  FundingChoices._();

  /// Singltone instance
  static FundingChoices _singleton;

  /// This factory allow to create the singleton instance
  /// An optional parameter [tagForUnderAgeOfConsent] is allowed to
  /// set tag for under age constent to true. Default value is false
  factory FundingChoices([bool tagForUnderAgeOfConsent]) {
    if (_singleton == null) {
      _singleton = FundingChoices._();
      _singleton._init(tagForUnderAgeOfConsent ?? false);
    }
    return _singleton;
  }

  /// Channel method invocation
  Future<void> _init(bool tagForUnderAgeOfConsent) {
    return _channel.invokeMethod(
        'init', {'tagForUnderAgeOfConsent': tagForUnderAgeOfConsent});
  }
}
