import 'package:covid_ambulance/Screens/Driver/driver_home.dart';
import 'package:covid_ambulance/Screens/Driver/driver_phone.dart';
import 'package:covid_ambulance/Screens/Driver/driver_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'finsh.dart';

class DriverSignIn extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<DriverSignIn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height / 7),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Let's Sign You In",
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Welcome!",
                style: TextStyle(fontSize: 17.0, color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Card(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 17),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Card(
                      child: TextField(
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.blue[900], fontSize: 17),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue[900],
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.blue[900],
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                  ),
                  //),
                  SizedBox(
                    height: 35.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 13,
                    child: RaisedButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordcontroller.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverHomeScreen()));
                        } catch (e) {
                          print(e);
                          var snackbar = SnackBar(content: Text(e.toString()));
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                        }
                      },
                      child: Text(
                        "Sign In",
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 19.0),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverSignUp()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 13,
                    child: RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPage()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriverPhone()));
                      },
                      child: Text(
                        "Log In Phone",
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 19.0),
                      ),
                      color: Colors.white,
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
