import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:im_flutter_sdk/im_flutter_sdk.dart';

import 'package:flutter/services.dart';
import 'package:rtc_flutter_sdk/rtc_flutter_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    EMOptions options = new EMOptions(appKey: "easemob-demo#chatdemoui");
    EMClient.getInstance().init(options);
    EMClient.getInstance().setDebugMode(true);

    EMClient.getInstance().login("du001", "1", onSuccess: (username){}, onError:(int, errorStr){
      log(errorStr);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await RtcFlutterSdk.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
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
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
