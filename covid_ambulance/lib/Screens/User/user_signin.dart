import 'package:covid_ambulance/Screens/User/home_screen.dart';
import 'package:covid_ambulance/Screens/User/user_phone.dart';
import 'package:covid_ambulance/Screens/User/user_sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignIn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/7),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Text("Let's Sign You In",style: TextStyle(fontSize: 35.0,color: Colors.blue[900]),),
              ),
              SizedBox(height: 15.0,),
               Padding(
                 padding: const EdgeInsets.only(left:25.0),
                 child: Text("Welcome!",style: TextStyle(fontSize: 17.0,color: Colors.lightBlue),),
               ),
               SizedBox(height: 35.0,),
               Center(
                 child: Column(
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width/1.1,
                       child: Card(
                           child:TextField(
                             keyboardType: TextInputType.emailAddress,
                             controller: _emailController,
                             decoration: InputDecoration(
                                labelText: "E-mail",
                                labelStyle: TextStyle(color: Colors.black,fontSize: 17),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                                  ),
                                prefixIcon: Icon(Icons.email),
                             ),
                           ),
                          ),
                        ),
                       SizedBox(height: 35.0,),
                       Container(
                         width: MediaQuery.of(context).size.width/1.1,
                         child: Card(
                           child: TextField(
                             controller: _passwordcontroller,
                             decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.black,fontSize: 17),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                                  ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon:Icon(_obscureText?Icons.visibility:Icons.visibility_off),
                                  onPressed: (){
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
                   SizedBox(height: 35.0,),
                   SizedBox(width: MediaQuery.of(context).size.width/1.1,
                   height: MediaQuery.of(context).size.height/13,
                   child: RaisedButton(
                    onPressed: (){
                      try{
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text, 
                          password: _passwordcontroller.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserHomeScreen()));
                      }catch(e){
                        print(e);
                        var snackbar = SnackBar(content: Text(e.toString()));
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                      }
                    },
                    child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 19.0),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),),
                    SizedBox(height: 25.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        FlatButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserSignUp()));
                        }, child: Text("Sign Up"),),
                      ],
                    ),
                    SizedBox(height: 35.0,),
                   SizedBox(width: MediaQuery.of(context).size.width/1.1,
                   height: MediaQuery.of(context).size.height/13,
                   child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UserPhone()));
                    },
                    child: Text("Log In Phone",style: TextStyle(color: Colors.white,fontSize: 19.0),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),),
                  ],
                 ), 
              ),
          ],
        ),
      ),
    );
  }
}