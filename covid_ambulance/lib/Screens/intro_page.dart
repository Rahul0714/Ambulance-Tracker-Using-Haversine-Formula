import 'package:covid_ambulance/Screens/auth_decide_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(pages: [
      PageViewModel(
        title: "Welcome to AppName",
        body:"Something",
        image: CircleAvatar(child: Image.asset("images/doctor_monochromatic.png"),
        backgroundColor: Color(0xffF39797),),
      ),
      PageViewModel(
        title: "Welcome to AppName",
        body:"Something",
        image: CircleAvatar(child: Image.asset("images/map_monochromatic.png"),
        backgroundColor: Color(0xffF39797),),
      ),
      PageViewModel(
        title: "Welcome to AppName",
        body:"Something",
        image: CircleAvatar(child: Image.asset("images/police_monochromatic.png"),
        backgroundColor: Color(0xffF39797),),
      ),
    ], 
    onDone: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthDecide()));
    }, 
    onSkip: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthDecide()));
    },
    showSkipButton: true,
    skip: Icon(Icons.skip_next,size: 40.0,),
    next: Icon(Icons.navigate_next,size: 40.0,),
    done: Text("Next"));
  }
}