import 'package:family_carpool/screens/onBoarding.dart';
import 'package:flutter/material.dart';
import 'themes/colors.dart';
import 'widgets/bottom_bar.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'
        ),
      ),
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
