import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAnalogClock extends StatefulWidget {
  @override
  _MyAnalogClockState createState() => _MyAnalogClockState();
}

class _MyAnalogClockState extends State<MyAnalogClock> {
  @override
    Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: AnalogClock(
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.blueGrey),
                  color: Colors.transparent,
                  shape: BoxShape.circle),
              width: 200.0,
              isLive: true,
              hourHandColor: Colors.black,
              minuteHandColor: Colors.black,
              secondHandColor: Colors.blueGrey,
              showSecondHand: true,
              numberColor: Colors.black87,
              showNumbers: true,
              textScaleFactor: 1.4,
              showTicks: true,
              showDigitalClock: false,


            ),
          ),
        ));

}
