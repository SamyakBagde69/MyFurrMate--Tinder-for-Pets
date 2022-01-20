import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furrmate/SecondModule/Info.dart';
import 'package:furrmate/SecondModule/Swipepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final auth = FirebaseAuth.instance;
final _firestore=  FirebaseFirestore.instance;

class RegistraionPage extends StatefulWidget {
  final String id = 'RegistrationPage';

  @override
  _RegistraionPageState createState() => _RegistraionPageState();
}

class _RegistraionPageState extends State<RegistraionPage> {
  late String email;
  late String password;


  CreateUserDocuments(){
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    users.doc(email).set({'Name':'','Email':email,'ImageLink':'','Liked':[],'MYMATCHCHAT':[]});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 300,width: double.infinity,
              child: Image.asset('images/reg.jpg',),),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                filled: true,
                  hintText: "ENTER EMAIL",
                  hintStyle: TextStyle(color: Color(0xFF1496FE),fontSize: 20,fontFamily: 'Dogfont' ),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Color(0xFFE4AC5C), width: 3),
                      borderRadius: BorderRadius.circular(30))),),

            SizedBox(
              height: 20,
            ),
            TextField(

              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(fillColor: Colors.white,
                filled: true,
                hintText: "ENTER PASSWORD",
                hintStyle: TextStyle(color: Color(0xFF1496FE),fontSize: 20,fontFamily: 'Dogfont' ),
                  enabledBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Color(0xFFE4AC5C), width: 3),
                      borderRadius: BorderRadius.circular(30))),
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
                        height:50,child: Text('REGISTER',style: TextStyle(fontSize: 25,fontFamily: 'Dogfont'),)),
                  ],
                ),onPressed: () async {

              try {
                UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password
                );
                CreateUserDocuments();
                if(userCredential!=null)
                  Navigator.pushNamed(context, InfoPage().id);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }


            }, )
          ],
        ),
      ),
    );
  }
}
