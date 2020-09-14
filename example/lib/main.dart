import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:funding_choices/funding_choices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String platformException = 'No errors';

  @override
  void initState() {
    super.initState();
    initFundingChoices();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initFundingChoices() async {
    String platformException;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      FundingChoices();
    } on PlatformException catch (e) {
      platformException = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      platformException = platformException;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(platformException),
        ),
      ),
    );
  }
}
