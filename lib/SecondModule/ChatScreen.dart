import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furrmate/ThirdModule/MatchedChat.dart';

FirebaseAuth _auth = FirebaseAuth.instance;



class chatscreen extends StatefulWidget {
  const chatscreen({Key? key}) : super(key: key);

  @override
  _chatscreenState createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = _auth.currentUser!.email;
getnam()async{
  var name = await _firestore.collection('Users').doc(user).get().then((value) => value.data()!['MYMATCHCHAT'])as List;

  print(name);
  return name;
 // return name.where((e) => e[]);

}
  @override
  Widget build(BuildContext context) {
getnam();
    return Scaffold(
      appBar: AppBar(backgroundColor:Color(0xFFE4AC5C),title: Text('CHATS',style: TextStyle(fontFamily: 'Dogfont'),),),
      body: Container(
        child: FutureBuilder(
          future: getnam(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            var Namelist = snapshot.data as List;
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(children: [Center(child:
              TextButton(

                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                          return matchedchat(snapshot.data[0]);
                        },)); },
                        child:Text("gfgf"))
            )]);
            }
            else {
              return CircularProgressIndicator();
            }
          }
        ),
      ),
    );
  }
}
