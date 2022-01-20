import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furrmate/FirstModule/LoginScreen.dart';
import 'package:furrmate/FirstModule/RegistrationScreen.dart';

class WelcomePage extends StatelessWidget {
  final String id = 'welcomescreen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(

          child: Column(
            children: [
              Container(child: Image.asset('images/wel.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: CircleBorder(),
                            side: BorderSide(color: Color(0xFFE4AC5C), width: 3),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, RegistraionPage().id);
                          },
                          child: Image.asset(
                            'images/cat.png',
                            height: 120,
                            width: 120,
                          )),
                      Text('Registeration',style: TextStyle(color: Color(0xFFE4AC5C),fontSize: 20,fontFamily: 'Dogfont' ),)
                    ],
                  ),
                  SizedBox(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          side: BorderSide(color: Color(0xFFE4AC5C), width: 3),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage().id);
                        },
                        child: Image.asset(
                          'images/dog.png',
                          height: 110,
                          width: 110,

                        ),
                      ),
                      Text('Login',style:TextStyle(color: Color(0xFFE4AC5C),fontSize: 20,fontFamily: 'Dogfont' ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
