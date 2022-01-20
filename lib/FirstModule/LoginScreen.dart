import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furrmate/SecondModule/Info.dart';

import '../SecondModule/Swipepage.dart';

class LoginPage extends StatefulWidget {
  final String id='LoginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height:300,
        child: Image.asset('images/reg.jpg'),),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                  hintText: "ENTER EMAIL",
                  hintStyle: TextStyle(color: Color(0xFF1496FE),fontSize: 15,fontFamily: 'Dogfont' ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Color(0xFFE4AC5C), width: 3),
                      borderRadius: BorderRadius.circular(30))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                 password = value;
              },
              decoration: InputDecoration(
                hintText: "ENTER PASSWORD",
                hintStyle: TextStyle(color: Color(0xFF1496FE),fontSize: 15,fontFamily: 'Dogfont' ),
                  filled: true,
                  fillColor: Colors.white,
                 enabledBorder:OutlineInputBorder(
                    borderSide:BorderSide(color: Color(0xFFE4AC5C), width: 3) ,
                      borderRadius: BorderRadius.circular(30),),),

            ),
            TextButton(
              style: OutlinedButton.styleFrom(
                shape: CircleBorder(),
                side: BorderSide(color: Color(0xFFE4AC5C), width: 5),
              ),

              child:Column(
                children: [

                Image.asset(
                  'images/dog.png',
                  height: 90,
                  width: 135,

                ),
                Container(
                    height:50,child: Text('LOGIN',style: TextStyle(fontSize: 20,fontFamily: 'Dogfont' ),)),
                ],
                ),
onPressed: ()=>{ Navigator.pushNamed(context, InfoPage().id)},)
            // onPressed: () async {
            //
            //   try {
            //     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            //         email: email,
            //         password: password
            //     );
            //     if (userCredential!=null){
            //       Navigator.pushNamed(context, InfoPage().id);
            //     }
            //   } on FirebaseAuthException catch (e) {
            //     if (e.code == 'user-not-found') {
            //       print('No user found for that email.');
            //     } else if (e.code == 'wrong-password') {
            //       print('Wrong password provided for that user.');
            //     }
            //   }
            //
            //
            //
            // }, )

          ],
        ),
      ),
    );
  }
}
