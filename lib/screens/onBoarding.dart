import 'dart:io';

import 'package:family_carpool/screens/home_page.dart';
import 'package:family_carpool/screens/welcome_page.dart';
import 'package:family_carpool/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:path_provider/path_provider.dart';
//import the page that comes after onboarding... likely login


class IntroScreen extends StatefulWidget {
  @override
  _IntroScreen createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final onboardPages = [
      Container(color: Colors.pinkAccent, child: FirstScreen()),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[300],
                  Colors.blue[700]
                ])),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          height: 340,
                          width: 10,
                          child: Image(
                              image: AssetImage('assets/images/Community.PNG',),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Text("Share your TidePool account with other parents",
                                    style: TextStyle(
                                        fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                                Text(
                                    "from your child's after school activities",
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                              ],
                            )),
                      ),
                    ]))),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[300],
                  Colors.blue[600]
                ])),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 400,
                          width: 200,
                          child: Image(
                            image: AssetImage('assets/images/Car.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                    'Then start sharing driving duties amongst eachother,',
                                    style: TextStyle(
                                        fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                                Text(
                                    'with other people that you trust.',
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]))),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[200],
                  Colors.blue[500]
                ])),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerRight,
                        child: skipButton(context),
                      ),
                      SizedBox(height: 100,),
                      Image.asset('assets/images/Calendar.PNG',
                        height: 200,
                        width: 200,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(children: <Widget>[
                              SizedBox(height: 180,),
                              Text(
                                  'We give you a calendar and directions to keep track',
                                  style: TextStyle(
                                      fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                              ),
                              Text(
                                  'so you can start saving time today.',
                                  style: TextStyle(
                                      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ]))),
      ),
      Container(
        child: FinalScreen(),
      )
    ];
    return Scaffold(
        body: LiquidSwipe(
          pages: onboardPages,
          fullTransitionValue: 400,
          enableLoop: true,
          enableSlideIcon: false,
          //positionSlideIcon: 0.8,
          waveType: WaveType.liquidReveal,
        ));
  }

  Widget skipButton(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinalScreen()),
        );
      },
      child: Text(
        'Skip',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }
}

class FinalScreen extends StatelessWidget {
  getSetLanguage()async{
    int val = 0;

  }

  Future checkSso(BuildContext context)async{

    String val = "";

    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/language.txt');
      String temp = await file.readAsString();
      val = temp;
    } catch (e) {
      print("Couldn't read file");
    }
    if(val!="")
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomBar()),
      );
    else{
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.lightBlueAccent,
          child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AvatarGlow(
                      endRadius: 150,
                      duration: Duration(seconds: 2),
                      glowColor: Colors.white24,
                      repeat: true,
                      repeatPauseDuration: Duration(seconds: 1),
                      startDelay: Duration(seconds: 1),
                      child: Material(
                          elevation: 25.0,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: FlutterLogo(
                              size: 100.0,
                            ),
                            radius: 100.0,
                          )),
                    ),
                    //SizedBox(height: 100,),
                    Center(
                      child: Text(
                          'Begin taking advantage of TidePool today!',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_forward_ios),
                        iconSize: 40,
                        onPressed:(){
                          checkSso(context);
                        }
                    )
                  ]))),
    );
    }


}
class FirstScreen extends StatefulWidget {
  final String title;

  FirstScreen({Key key, this.title}) : super(key: key);

  @override
  _FirstScreen createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  // Whether the green box should be visible
  bool _buttonVisible = true;
  bool _textVisible = false;

  TextEditingController ipController = new TextEditingController();

  setIP() async{

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/ip.txt');
    await file.writeAsString("http://"+ipController.text.toString()+":8080/");

    String temp = await file.readAsString();
    print(temp);

    Navigator.pop(
        cont
    );
  }


  _diplayIPChange() async {
    return showDialog(
        context: cont,
        builder: (context) {
          return AlertDialog(
            title: Text('What is the IP Address of the Running Local Computer?'),
            content: TextField(
              controller: ipController,
              decoration: InputDecoration(hintText: "Usually found in network settings "),
            ),
            actions: <Widget>[
              new FlatButton(
                  child: new Text('OK'),
                  onPressed:setIP
              )
              ,new FlatButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
  BuildContext cont;
  @override
  Widget build(BuildContext context) {
    cont = context;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _diplayIPChange,
        child: Icon(Icons.menu),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[400],
                  Colors.blue[800]
                ])),
        child: Container(
          width: 400,
          child: Column(
            children: [
              SizedBox(height: 200,),
              Image.asset('assets/images/bluecar.png',
                height: 300,
                width: 300,
              ),
              SizedBox(height: 100),
              Text(
                  'Welcome to TidePool.',
                  style: TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
