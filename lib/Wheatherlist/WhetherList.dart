import 'dart:convert';
import 'package:flutter/material.dart';
import 'Wheather.dart';
import 'Wheathercard.dart';
import 'http.dart';

class WheatherList extends StatefulWidget {
  @override
  _WheatherListState createState() => _WheatherListState();
}

class _WheatherListState extends State<WheatherList> {
  int counting = 0;
  List<Wheather> wheather = [];
  bool listflag = false;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController txc = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheather APP'),
        backgroundColor: Colors.blueGrey,
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: txc,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    toggleSubmitState();
                    try {
                      dio.get<String>(
                          "https://www.metaweather.com/api/location/search/",
                          queryParameters: {"query": txc.text}).then((r) {
                        setState(() {
                          listflag = true;
                          print(r.data);
                          wheather = (json.decode(r.data) as List)
                              .map((i) => Wheather.fromJson(i))
                              .toList();
                          if(wheather.isEmpty){
                            listflag = false;

                          }
                          wheather.sort((a, b) => a.title.compareTo(b.title));
                          toggleSubmitState();
                        });
                      });
                    } catch (Exception) {
                      print(Exception);
                    }
                  },
                  icon: Icon(Icons.search),
                ),
                hintText: "Enter Cityname",
              ),
            ),
          ),
          showProgress
              ? Container(child: Center(child: CircularProgressIndicator()))
              : SizedBox(
            height: 1.0,
          ),
          listflag
              ? Container(
            decoration: new BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 50.0),
                  top: Radius.elliptical(
                      MediaQuery.of(context).size.width, 50.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10.0, bottom: 20.0),
              child: Column(
                children: listflag
                    ? wheather
                    .map((wres) => Wheathercard(
                  w: wres,
                  showdetail:(){
                    setState(() {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Details'),
                              content: Container(
                                height: 200.0,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                    ),
                                    Text(wres.title),
                                    Text(wres.lattLong),
                                    Container(
                                        width:150.0,height:100.0 ,
                                        child: Image.network('https://source.unsplash.com/random')),


                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('Back'),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          });
                    });
                  } ,

                ))
                    .toList()
                    : wheather
                    .map((wres) => Wheathercard(
                  w: wres,
                ))
                    .toList(),
              ),
            ),
          )
              : SizedBox(
            height: 1.0,
          ),
        ],
      ),
    );
  }

  void toggleSubmitState() {
    setState(() {
      showProgress = !showProgress;
    });
  }
}
