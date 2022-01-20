import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extra.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
class matchedchat extends StatefulWidget {
  final name;
matchedchat(this.name);

  @override
  _matchedchatState createState() => _matchedchatState();
}

class _matchedchatState extends State<matchedchat> {

  final messagetextcontroller = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = _auth.currentUser!.email;
  late final getnamedata;
  late String message;
@override
  void initState() {
    super.initState();
    getnamedata = widget.name;
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('CHATCA').orderBy("time").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('sorry no data');
                } else {
                  var messagedata = snapshot.data!.docs.reversed;
                  List<Widget> sentmessages = [];
                  messagedata.forEach((element) {
                    var data = element['text'];
                    var sender = element['sender'];
                    var currentuser = user;
                    sentmessages.add(messagebubble(
                      data: data,
                      sender: sender,
                      isMe: currentuser == sender,
                    ));
                  });
                  return Expanded(
                    child: ListView(reverse: true, children: sentmessages),
                  );
                }
              }),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messagetextcontroller,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      message = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messagetextcontroller.clear();
                    _firestore.collection(getnamedata['ref']).add({
                      'text': message,
                      'sender': user,
                      'time': DateTime.now()
                    });
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
    // return Scaffold(
    //   body: Container(
    //    child: StreamBuilder(
    //      stream: _firestore.collection(getnamedata['ref']).snapshots(),
    //      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
    //      {
    //      if (!snapshot.hasData) {
    //      return Text('sorry no data');
    //      } else {
    //      var messagedata = snapshot.data.docs.reversed;
    //        ListView.builder(
    //            itemBuilder: itemBuilder)
    //      },
    //
    //    ),
    //   ),
    // );
  }
}

  class messagebubble extends StatelessWidget {
  final String data;
  final String sender;
  final bool isMe;
  messagebubble({required this.sender, required this.data, required this.isMe});

  @override
  Widget build(BuildContext context) {
  return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
  crossAxisAlignment:
  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  children: [
  Text(sender),
  Material(
  elevation: 10,
  borderRadius: isMe
  ? BorderRadius.only(
  bottomLeft: Radius.circular(20.0),
  topLeft: Radius.circular(20.0),
  bottomRight: Radius.circular(20.0))
      : BorderRadius.only(
  bottomLeft: Radius.circular(20.0),
  bottomRight: Radius.circular(20.0),
  topRight: Radius.circular(20.0)),
  color: isMe ? Colors.blueAccent : Colors.pink,
  child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
  "$data",
  style: TextStyle(fontSize: 20, color: Colors.white),
  ),
  ),
  ),
  ],
  ),
  );
  }
  }