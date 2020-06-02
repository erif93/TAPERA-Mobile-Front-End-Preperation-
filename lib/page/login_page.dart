import 'package:flutter/material.dart';
import '../model/post_result_model.dart';
import 'Dashboard.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Form "),
        centerTitle: true,
        backgroundColor: Colors.blue
     ),
      body: loginForm(), 
    );
  }
}

class loginForm extends StatefulWidget {
  @override
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  
  final _formKey = GlobalKey<FormState>();
  PostResult postResult = null;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    validator: (usernameController){
                      if (usernameController.isEmpty) {
                        return 'Please enter username';
                      }
                      return null; 
                    },
                    decoration: InputDecoration(
                      labelText: 'username',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (passwordController){
                      if (passwordController.isEmpty) {
                      return 'Please enter password';
                      }
                      return null; 
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
               // Text((postResult != null) ? postResult.sessionUser : 'tidak ada data'),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: (){
                      if (_formKey.currentState.validate()) {
                      //print(usernameController.text);
                      //print(passwordController.text);
                        PostResult.connectToAPI(usernameController.text, passwordController.text).then((value) {
                        postResult = value;
                        setState(() {});
                        if(postResult.status == 'approved' ){
                          Navigator.pushReplacement( //aku ganti bagian ini biar ga bikin stack
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                          //  builder: (context) => Dashboard(text: postResult.sessionUser,),
                            )
                          );
                        }else{
                         Scaffold.of(context).showSnackBar(SnackBar(content: Text(postResult.message)));
                        }
                        });
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
            ),)
          ),
        ],
      ),
    );
  }
}