import 'package:covid_ambulance/Screens/Police/police_home.dart';
import 'package:covid_ambulance/services/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PoliceOtpCheck extends StatefulWidget {
  final String phone;
  PoliceOtpCheck(this.phone);
  @override
  _OtpCheckState createState() => _OtpCheckState();
}

class _OtpCheckState extends State<PoliceOtpCheck> {
  String _verificationCode;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
@override
  void initState() {
     _verifyPhone();
    super.initState();
  }
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PoliceHomeScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          if(this.mounted)
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          if(this.mounted)
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }@override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.blue[900],
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text('Verify Otp for +91${widget.phone}',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 35.0,),
                PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(fontSize: 25.0, color: Colors.blue),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  selectedFieldDecoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ).copyWith(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  followingFieldDecoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (String pin) async{
                    try{
                      await FirebaseAuth.instance.signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: _verificationCode, 
                        smsCode: pin),
                    ).then((value) async{
                      if(value.user!=null)
                        if(value.user.displayName!=null){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PoliceHomeScreen()));
                        }else{
                          showDialog(context: context,
                          builder: (_)=>AlertDialog(
                            title: Text("Enter Name"),
                            content: Column(children: [
                              TextField(
                              keyboardType: TextInputType.name,
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.black,fontSize: 17),
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), 
                                ),        
                            ),
                          ),
                          RaisedButton(
                            child: Text("Next"),
                            onPressed: (){
                            policeCollection.doc(
                              FirebaseAuth.instance.currentUser.uid).set({
                                'id':FirebaseAuth.instance.currentUser.uid,
                                'name':_nameController.text,
                                'phone':widget.phone,
                              }).then((value)async{
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PoliceHomeScreen()));
                              });
                              FirebaseAuth.instance.currentUser.updateProfile(
                                displayName:_nameController.text,
                              );
                          })
                            ],)
                          ));
                        }
                    });
                    }catch(e){
                      print("Invalid OTP");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}