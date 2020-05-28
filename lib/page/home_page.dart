import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String text;
  HomePage({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
              'Welcome ' + text,
            ),
      )
    );
  }
}