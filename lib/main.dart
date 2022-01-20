import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furrmate/SecondModule/Info.dart';
import 'package:furrmate/SecondModule/Swipepage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'FirstModule/LoginScreen.dart';
import 'FirstModule/RegistrationScreen.dart';
import 'FirstModule/WelcomScreen.dart';
void main() {

  runApp(MyApp());
  Firebase.initializeApp();

}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // SplashScreenView(
    //   pageRouteTransition:PageRouteTransition.SlideTransition,
    //   speed: 100,
    //   navigateRoute: WelcomePage(),
    //   duration: 2000,
    //   imageSize: 50,
    //   imageSrc: "logo.png",
    //   text: "Splash Screen",
    //   textType: TextType.ScaleAnimatedText,
    //   textStyle: TextStyle(
    //     fontSize: 30.0,
    //   ),
    //   backgroundColor: Color(4920083),
    // );
    return MaterialApp(
      initialRoute: WelcomePage().id,
      routes: {
        Swipepage('').id:(context)=>Swipepage(''),
        WelcomePage().id:(context) => WelcomePage(),
        LoginPage().id:(context) => LoginPage(),
        RegistraionPage().id:(context) => RegistraionPage(),
        InfoPage().id:(context) => InfoPage(),

      },
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
    );
  }
}


