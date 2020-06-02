import 'package:flutter/material.dart';
import 'package:friendlistview_latihan28/model/userdata_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'update_page.dart';
import '../model/api_service.dart';

import 'Dummy.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  BuildContext context;
  ApiService apiService;

  @override
  Map data;
  List userData;
  Future getData() async {
    http.Response response =
        await http.get("http://35.198.233.87:8080/profile");
    //debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    //debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("MII - Listview Demo"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                          text:
                              "ini tempat kosong buat naro page selanjutnya aja sih"),
                      //  builder: (context) => Dashboard(text: postResult.sessionUser,),
                    ),
                  );
                })
          ],
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  new Card(
                    child: Container(
                      height: 100,
                      width: 200,
                      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                           // UserData.firstName,
                              "${userData[index]["firstName"]} "
                              "${userData[index]["lastName"]}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "${userData[index]["description"]}",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UpdateData();
                                // return HomePage(text: "Faiq Test",);
                              }));
                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Warning"),
                                      content: Text(
                                          "Are you sure want to delete data profile ${userData[index]["firstName"]}?"),
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text("Yes"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            apiService
                                                .deleteProfile(
                                                    userData[index]["id"])
                                                .then((isSuccess) {
                                              if (isSuccess) {
                                                setState(() {});
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data success")));
                                              } else {
                                                Scaffold.of(this.context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Delete data failed")));
                                              }
                                            });
                                          },
                                        ),
                                        RaisedButton(
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ])
                ],
              );
            }),
      ),
    );
  }
}
