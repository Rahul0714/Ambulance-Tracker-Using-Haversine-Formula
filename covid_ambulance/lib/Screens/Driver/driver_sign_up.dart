import 'package:covid_ambulance/Screens/Driver/driver_phone.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<DriverSignUp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/7),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Text("Getting Started",style: TextStyle(fontSize: 35.0,color: Colors.blue[900]),),
              ),
              SizedBox(height: 15.0,),
               Padding(
                 padding: const EdgeInsets.only(left:25.0),
                 child: Text("Create an Account to Continue!",style: TextStyle(fontSize: 17.0,color: Colors.lightBlue),),
               ),
               SizedBox(height: 25.0,),
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
                        SizedBox(height: 25.0,),
                        Container(
                       width: MediaQuery.of(context).size.width/1.1,
                       child: Card(
                           child:TextField(
                             controller: _userNameController,
                             decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(color: Colors.black,fontSize: 17),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                                  ),
                                prefixIcon: Icon(Icons.person),
                             ),
                           ),
                          ),
                        ),
                       SizedBox(height: 25.0,),
                       Container(
                         width: MediaQuery.of(context).size.width/1.1,
                         child: Card(
                           child: TextField(
                             controller: _passwordController,
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
                   SizedBox(height: 25.0,),
                   SizedBox(width: MediaQuery.of(context).size.width/1.1,
                   height: MediaQuery.of(context).size.height/13,
                   child: RaisedButton(
                    onPressed: (){
                      try{
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text, 
                          password: _passwordController.text)
                          .then((signedUser){
                            driverCollection.doc(signedUser.user.uid).set({
                              'id':signedUser.user.uid,
                              'name':_userNameController.text,
                              'email':_emailController.text,
                              'password':_passwordController.text,
                            });
                          });
                          Navigator.pop(context);
                      }catch(e){
                        print(e);
                        var snackbar = SnackBar(content: Text(e.toString()));
                        _scaffoldKey.currentState..showSnackBar(snackbar);
                      }
                    },
                    child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 19.0),),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),),
                    SizedBox(height: 25.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Have an account already?"),
                        FlatButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("Sign In"),),
                      ],
                    ),
                    SizedBox(height: 25.0,),
                   SizedBox(width: MediaQuery.of(context).size.width/1.1,
                   height: MediaQuery.of(context).size.height/13,
                   child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverPhone()));
                    },
                    child: Text("Login With Phone",style: TextStyle(color: Colors.white,fontSize: 19.0),),
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
