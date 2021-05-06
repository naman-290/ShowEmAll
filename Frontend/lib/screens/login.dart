import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_app/screens/home.dart';
import 'package:streaming_app/screens/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool skipIsPressed = true, signupIsPressed = true, vis = true;
  var email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.grey[900],
                Colors.grey[800],
                Colors.grey[700],
                Colors.grey[600],
                Colors.grey[700],
                Colors.grey[800],
                Colors.grey[900],
              ])),
            ),
            Center(
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  // Opacity(
                  //   opacity: _visible ? 1.0 : 0.0,
                  // ),
                  // decoration: BoxDecoration(
                  //   gradient:
                  //       LinearGradient(colors: [Colors.grey[900], Colors.white]),
                  // ),
                  height: 260.0,
                  width: 300.0,
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white)),
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.0),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        vis = !vis;
                                      });
                                    },
                                    icon: vis
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  ),
                                ),
                                labelStyle: TextStyle(color: Colors.white)),
                            obscureText: vis,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 6) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {},
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(height: 15.0),
                          RaisedButton(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                login_fun(email, password, context);
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    signupIsPressed = !signupIsPressed;
                                  });
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Signup()));
                                },
                                child: Text(
                                  "Don't have account | Signup",
                                  style: signupIsPressed
                                      ? TextStyle(color: Colors.white)
                                      : TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                child: Text('Skip',
                                    style: skipIsPressed
                                        ? TextStyle(color: Colors.white)
                                        : TextStyle(color: Colors.blue)),
                                onPressed: () {
                                  setState(() {
                                    skipIsPressed = !skipIsPressed;
                                  });
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              homeScreen()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

login_fun(email, password, context) async {
  var url = "http://10.0.2.2:3000/api/login";

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'password': password}),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    //print(response.body);
    Map<String, dynamic> details = await jsonDecode(response.body);
    // print(details['status']);
    if (details['status'] == 'true') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => homeScreen()));
    } else {
      print(details['message']);
    }
  }
}
