import 'package:flutter/material.dart';
import 'package:net_ninja/Alarm.dart';
import 'package:net_ninja/quotelist/dynamiclist.dart';
import 'Native/Alarm_event.dart';
import 'Native/batterylevel.dart';
import 'Native/event_channel_page.dart';
import 'clock/Clock.dart';
import 'waves/Waves.dart';
import 'Wheatherlist/WhetherList.dart';
import 'moor_list/goals_screen.dart';
import 'moor_list/myapp.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.lightGreen,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: (
        Column(
          children: [
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Basic QuoteList')),
                  Icon(Icons.accessibility_new),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dynamiclist()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('DIO Wheather List')),
                  Icon(Icons.location_on),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WheatherList()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('MOOR GOAL List')),
                  Icon(Icons.add_to_photos),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Waves')),
                  Icon(Icons.ac_unit),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WaveDemoApp()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Clock')),
                  Icon(Icons.timer),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAnalogClock()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Ringing tone player')),
                  Icon(Icons.airline_seat_flat),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAlarmApp()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Native - method channel')),
                  Icon(Icons.android),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetBatterylevel()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Native -Event channel')),
                  Icon(Icons.android),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventChannelPage()),
                );
              },
            ),
            FlatButton(
              child: Row(
                children: [
                  Center(child: Text('Alarm')),
                  Icon(Icons.android),
                ],
              ),
              color: Colors.greenAccent,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlarmPage()),
                );
              },
            ),
          ],
        )
        ),
      ),


    );
  }
}
