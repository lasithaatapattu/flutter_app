import 'package:flutter/material.dart';
import 'file:///D:/Flutter/Projects/net_ninja/lib/quotelist/quotes.dart';
class Quotecard extends StatelessWidget {
  Function delete;
  quotes quot;
  Quotecard({this.quot, this.delete});
  @override
  Widget build(BuildContext context) {
    return Card(

        child:Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Quote :'),
                    Text('${quot.name}'
                    ),
                  ],),
                Row(
                  children: [
                    Text('Author : '),
                    Text('${quot.text}'
                    ),
                  ],),

                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0,8.0,50.0,8.0),
                  child: FlatButton(
                    child: Row(
                      children: [
                        Text('delete'),
                        Icon(Icons.delete),
                      ],
                    ),
                    color: Colors.redAccent,
                    onPressed:delete,
                  ),
                ),
                SizedBox(height: 8.0,),

              ],
            ),
          ),
        )
    );
  }
}
