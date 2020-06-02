import 'package:flutter/material.dart';
import '../model/userdata_model.dart';
import 'Dashboard.dart';

void main() {
  runApp(new MaterialApp(
    home: new UpdateData(),
  ));
}

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class UpdateData extends StatefulWidget { 
  UserData userData;

  UpdateData({this.userData}); 

  @override
  _UpdateDataState createState() => new _UpdateDataState();
}


class _UpdateDataState extends State<UpdateData> {
  bool _isLoading = false;
  UserData _userData = UserData();
  bool _isFieldFirstNameValid;
  bool _isFieldLastNameValid;
  TextEditingController firstnameController;
  TextEditingController lastnameController;

  @override
  void initState() {
    if (widget.userData != null) {
      _isFieldFirstNameValid = true;
      firstnameController.text = widget.userData.firstname;
      _isFieldLastNameValid = true;
      lastnameController.text = widget.userData.lastname;
    }
    super.initState();
  }

  void updateData() {
    
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update data?"),
          actions: <Widget>[
            RaisedButton(
              child: new Text("Yes"),
              textColor: Colors.white,
              color: Colors.black,
              onPressed: (){
                if (_isFieldFirstNameValid == null ||
                    _isFieldLastNameValid == null ||
                    !_isFieldFirstNameValid ||
                    !_isFieldLastNameValid){
                      _scaffoldState.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Please fill all field")
                        )
                      );
                      return;
                    }
                    setState(() => _isLoading = true);
                    String firstname = firstnameController.toString();
                    String lastname = lastnameController.toString();
                    UserData userData = UserData(firstname: firstname, lastname: lastname);
                    if (widget.userData == null) {

                    }
              }
            ),

            RaisedButton(
              child: new Text("No"),
              textColor: Colors.white,
              color: Colors.black,
              onPressed: () => showAlert(context),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () => Dashboard,),
        title: new Text("Update"),
        backgroundColor: Colors.blue,

      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                controller: lastnameController,
                decoration: new InputDecoration(
                  hintText: "First Name",
                  labelText: "First Name",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10)
                  )
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 10.0)
              ),

              new TextField(
                controller: lastnameController,
                decoration: new InputDecoration(
                    hintText: "Last Name",
                    labelText: "Last Name",
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10)
                    )
                ),
              ),

              new Padding(padding: new EdgeInsets.only(top: 10.0)
              ),

              new RaisedButton(
                child: new Text("Update"),
                textColor: Colors.white,
                color: Colors.black,
                onPressed: () => showAlert(context),
              )

            ],
          ),

      )
    );
  }

}

