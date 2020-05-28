import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
 String text;
  HomePage({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Center(
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
                  "Hello " + text,
                  ),
          ),
        ),
      )
    );
  }
}