import 'package:flutter/material.dart';
import '../model/post_result_model.dart';
import 'Dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PostResult postResult = null;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text("Login Form "),
      centerTitle: true,
      backgroundColor: Colors.blue
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'username',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    
                  ),
                  obscureText: true,
                ),
               // Text((postResult != null) ? postResult.sessionUser : 'tidak ada data'),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: (){
                    print(usernameController.text);
                    print(passwordController.text);
                    PostResult.connectToAPI(usernameController.text, passwordController.text).then((value) {
                      postResult = value;
                      setState(() {});

                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                        //  builder: (context) => Dashboard(text: postResult.sessionUser,),
                    ),);
                      
                    });
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ), 
  );
  }
}