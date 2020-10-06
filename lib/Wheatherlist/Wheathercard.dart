import 'package:flutter/material.dart';
import 'Wheather.dart';
import 'file:///D:/Flutter/Projects/net_ninja/lib/quotelist/quotes.dart';

class Wheathercard extends StatelessWidget {
  Wheather w;
  Function showdetail;

  Wheathercard({this.w,this.showdetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan,
        child: Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      child: Container(
        child: Row(

          children: [
            Expanded(
                flex: 2,
                child: Text('${w.title}')),
            Expanded(
                flex: 2,
                child: Text('${w.woeid}')),
            Expanded(
                flex: 1,
                child: Text('${w.locationType}')),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: Colors.blueGrey,
                child: Icon(Icons.navigate_next),
                onPressed:showdetail,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    ));
  }
}
