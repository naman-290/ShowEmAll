import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:streaming_app/Network/NetworkHandler.dart';
import 'package:streaming_app/screens/home.dart';
import 'package:streaming_app/screens/login.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email, password, username;
  bool loginIsPressed = true;
  bool isEmail = true, vis = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
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
                // Colors.grey[500],
                Colors.grey[600],
                Colors.grey[700],
                Colors.grey[800],
                Colors.grey[900],
              ]),
            ),
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
                height: 300.0,
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
                              labelText: "Username",
                              labelStyle: TextStyle(color: Colors.white)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'invalid Username';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          onChanged: (value) {
                            username = value;
                          },
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'invalid Email';
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
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 6) {
                              return 'Invalid Passwod';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(height: 10.0),
                        RaisedButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //networkHandler.post("");
                              signup_fun(email, password, username, context);
                            }
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              loginIsPressed = !loginIsPressed;
                            });
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          },
                          child: Text(
                            "Alreadt have an account | Login",
                            style: loginIsPressed
                                ? TextStyle(color: Colors.white)
                                : TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

signup_fun(email, password, username, context) async {
  var url = "http://10.0.2.2:3000/api/register";

  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password': password
    }),
  );
  if (response.statusCode == 200) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Login()));
  } else {}
}
