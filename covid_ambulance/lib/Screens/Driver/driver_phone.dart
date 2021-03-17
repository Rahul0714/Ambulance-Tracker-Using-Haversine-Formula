import 'package:covid_ambulance/Screens/Driver/driver_otp_check.dart';
import 'package:flutter/material.dart';

class DriverPhone extends StatefulWidget {
  @override
  _UserPhoneState createState() => _UserPhoneState();
}

class _UserPhoneState extends State<DriverPhone> {
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height/7),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Text("Let's Sign You In",style: TextStyle(fontSize: 35.0,color: Colors.blue[900]),),
              ),
              SizedBox(height: 15.0,),
              Padding(
                padding: const EdgeInsets.only(left:25.0),
                child: Text("Welcome back, you’ve been missed!",style: TextStyle(fontSize: 17.0,color: Colors.lightBlue),),
              ),
              SizedBox(height: 35.0,),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Card(
                    child:TextField(
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(color: Colors.black,fontSize: 17),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                          ),
                          prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.0,),
                   SizedBox(width: MediaQuery.of(context).size.width/1.1,
                   height: MediaQuery.of(context).size.height/13,
                   child: RaisedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DriverOtpCheck(_phoneController.text)));
                    },
                    child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 19.0),),
                    color: Colors.blue,
                    ),),
        ],),
      )
    );
  }
}