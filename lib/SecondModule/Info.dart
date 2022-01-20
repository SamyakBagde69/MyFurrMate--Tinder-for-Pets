import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:furrmate/SecondModule/Swipepage.dart';
import 'package:path_provider/path_provider.dart';

FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

CollectionReference users = FirebaseFirestore.instance.collection('Users');

class InfoPage extends StatefulWidget {
  final String id = 'InfoPage';

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User loggedinuser;
  String Name = '';
  var Link;
  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  ImageUpload_UpdateData() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      File file = File(result.files.first.path.toString());
      await firebase_storage.FirebaseStorage.instance
          .ref('$Name/1.png')
          .putFile(file);

      Link = await firebase_storage.FirebaseStorage.instance
          .ref('$Name/1.png')
          .getDownloadURL();

      await users.doc(loggedinuser.email).update({'ImageLink': Link});

      // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      //     .ref(result.files.first.path);
    } else {
      // User canceled the picker
    }
  }
///////////////////////////////

  ////////////////////////////
  getcurrentuser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinuser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  ///////////////////////////////

  ///////////////////////////
  // Future<void> downloadURLExample() async {
  //   var Link = await firebase_storage.FirebaseStorage.instance
  //       .ref('uploads/Screenshot (47).png')
  //       .getDownloadURL();

  //Link=downloadURL;

  // Within your widgets:
  // Image.network(downloadURL);
  // }
  ////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
              enableSuggestions: true,
              autocorrect: true,
              onChanged: (value) {
                Name = value;
              },
              decoration: InputDecoration(
                  filled: true,
                  hintText: "ENTER   YOUR   USERNAME",

                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFE4AC5C), width: 2),
                      borderRadius: BorderRadius.circular(30)))),
          SizedBox(),
          Container(
            child: OutlinedButton(
              onPressed: () {
                Name == '' || Name == null
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Color(0xFFE4AC5C),
                        duration: Duration(seconds: 2),
                        content: Text('Please Enter Name')))
                    : ImageUpload_UpdateData();
              },
              child: Text('upload image'),
            ),
          ),
          Container(
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, Swipepage(Link).id);
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  //
  // Future<void> uploadFile(String filePath) async {
  //   File file = File(result.files.first.path);
  //
  //   try {
  //
  //   }
  //   catch (e) {
  //     // e.g, e.code == 'canceled'
  //   }
  // }

}
