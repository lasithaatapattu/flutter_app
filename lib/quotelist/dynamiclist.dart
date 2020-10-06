
import 'package:flutter/material.dart';
import 'package:net_ninja/main.dart';
import 'file:///D:/Flutter/Projects/net_ninja/lib/quotelist/quotes.dart';

import 'Quotecard.dart';
class dynamiclist extends StatefulWidget {
  @override
  _dynamiclistState createState() => _dynamiclistState();
}

class _dynamiclistState extends State<dynamiclist> {
  TextEditingController _textFieldQuotes = TextEditingController();
  TextEditingController _textFieldAuthor = TextEditingController();
  List<quotes> quaotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote List'),
      ),
      body: Column(
        children: quaotes.map((quotes) => Quotecard(
          quot: quotes,
          delete: () {
            setState(() {
              quaotes.remove(quotes);
            });
          },
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('ADD'),
                    content: Container(
                      height: 120.0,
                      child: Column(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.red,
                          ),
                          TextField(
                            controller: _textFieldAuthor,
                            decoration: InputDecoration(hintText: "Author"),
                          ),
                          TextField(
                            controller: _textFieldQuotes,
                            decoration: InputDecoration(hintText: "Quote"),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('Add'),
                        onPressed: () {
                          setState(() {
                            quaotes.add(quotes(
                                _textFieldQuotes.text, _textFieldAuthor.text));
                            _textFieldAuthor.text = '';
                            _textFieldQuotes.text = '';

                            Navigator.of(context).pop();
                          });
                        },
                      ),
                      new FlatButton(
                        child: new Text('Cancel'),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                    ],
                  );
                });
          });
        },
      ),
    );
  }
}
