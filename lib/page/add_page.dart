import '../model/api_service.dart';
import '../model/userdata_model.dart';
import 'package:flutter/material.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldIdValid;
  bool _isFieldFirstnameValid;
  bool _isFieldLastnameValid;
  TextEditingController _controllerId = TextEditingController();
  TextEditingController _controllerFirstname = TextEditingController();
  TextEditingController _controllerLastname = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldId(),
                _buildTextFieldFirstname(),
                _buildTextFieldLastname(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      print("Data Added.");
                      if (_isFieldIdValid == null ||
                          _isFieldFirstnameValid == null ||
                          _isFieldLastnameValid == null ||
                          !_isFieldIdValid ||
                          !_isFieldFirstnameValid ||
                          !_isFieldLastnameValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      int id = int.parse(_controllerId.text.toString());
                      String firstname = _controllerFirstname.text.toString();
                      String lastname = _controllerLastname.text.toString();

                      UserData userdata =
                      UserData(id: id, firstname: firstname, lastname: lastname);
                      _apiService.createProfile(userdata).then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess) {
                          Navigator.pop(_scaffoldState.currentState.context);
                        } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Submit data failed"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldId() {
    return TextField(
      controller: _controllerId,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "ID",
        errorText: _isFieldIdValid == null || _isFieldIdValid
            ? null
            : "ID is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldIdValid) {
          setState(() => _isFieldIdValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldFirstname() {
    return TextField(
      controller: _controllerFirstname,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Firstname",
        errorText: _isFieldFirstnameValid == null || _isFieldFirstnameValid
            ? null
            : "Firstname is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstnameValid) {
          setState(() => _isFieldFirstnameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLastname() {
    return TextField(
      controller: _controllerLastname,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Lastname",
        errorText: _isFieldLastnameValid == null || _isFieldLastnameValid
            ? null
            : "Lastname is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLastnameValid) {
          setState(() => _isFieldLastnameValid = isFieldValid);
        }
      },
    );
  }
}