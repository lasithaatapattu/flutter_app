import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net_ninja/DB/moor_database.dart';
import 'package:provider/provider.dart';
import 'goals_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (BuildContext context) => AppDatabase(),
      child: MaterialApp(
        title: 'Goals',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GoalsScreen(),
      ),
    );
  }
}
