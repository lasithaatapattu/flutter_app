import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  static const _stream = const EventChannel('samples.flutter.alarm');
  String _orientation = "Portrait";
  StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    subscription = _stream.receiveBroadcastStream().listen((orientation){
      setState(() {
        _orientation = orientation;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Channel'),
      ),
      body: Center(child: Text(_orientation, style: Theme.of(context).textTheme.display2,)),
    );
  }
}
