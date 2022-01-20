import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furrmate/SecondModule/ChatScreen.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
FirebaseAuth _auth = FirebaseAuth.instance;
class Swipepage extends StatefulWidget {
  Swipepage(this.link);
   var link;
  final String id='Swipescreen';
  @override
  _SwipepageState createState() => _SwipepageState();
}

class _SwipepageState extends State<Swipepage> {


  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var user = _auth.currentUser!.email;


  List<Map> Otherlist = [];
  Map otheruser = {};
  List ImageLinks = [];
  List <Image>DownloadImages = [];

  // List<String>ImageLinks=List.generate(4, (index) => _firestore.collection('Users').where('Email'!= user).get()
  // List <Image>UserCards=List.generate(4, (index) => Image.network('src'))

  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;


  @override
  void initState() {
    super.initState();
    /////////////////////////////////


    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  getImage() async {
    await getdata();
    DownloadImages = await List.generate(
        Otherlist.length, (index) => Image.network(Otherlist[index]['link']));
    for (int i = 0; i < DownloadImages.length; i++) {
      _swipeItems.add(SwipeItem(
          content: DownloadImages[i],
          likeAction: () async {
            await check(i);
          },
          // map((e) { ImageLinks.add(e.data()['ImageLink']);});


          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope ${[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked ${[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          }));
    }
  }

  getdata() async {
    var data = await _firestore.collection('Users').where(
        'Email', isNotEqualTo: user).get();
    data.docs.forEach((e) {
      otheruser = {'email': e.data()['Email'], 'link': e.data()['ImageLink']};
      Otherlist.add(otheruser);
    });

    // otheruser['email']=e.data()['Email'];
    // otheruser['link']=e.data()['ImageLink'];
    //e.data()['ImageLink']
    //forEach((value) {print(value.id);});

  }

  //*******************************************
  // getdata()async{
  //   var data= await _firestore.collection('Users').where('Email',isNotEqualTo: user ).get();
  //    data.docs.map((e) { ImageLinks.add(e.data()['ImageLink']);});
  //   print(ImageLinks[1]);
  //   //e.data()['ImageLink']
  //   //forEach((value) {print(value.id);});
  //
  // }
  //***************************************
//  getdata() async {
//     var data = await _firestore.collection('Users')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         print(doc.id);
//       });
//     });
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Furrmate'),
        ),
//         body: Center(
//           child: Container(
//     child:FutureBuilder(
//       future: null,
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
// return DogList[1];
//
//       },) ,
//******************************************
        body: Stack(
            children: [
              Align(alignment: Alignment.center,
                child: FutureBuilder(
                    future: getImage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SwipeCards(
                          matchEngine: _matchEngine,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              alignment: Alignment.center,
                              child: _swipeItems[index].content,
                              height: 500,
                              width: 300,
                            );
                          },
                          onStackFinished: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Stack Finished"),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                        );
                      }
                      else {
                        return CircularProgressIndicator();
                      }
                    }
                ),
              ),
              Align(alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) {
                            return chatscreen();
                          }));
                        },
                        child: Text("chat")),
                    TextButton(
                        onPressed: () {
                          _matchEngine.currentItem!.nope();
                        },
                        child: Image.asset('images/nope.png',height: 50,width: 50,)
                        ),
                    // TextButton(
                    //     onPressed: () {
                    //       _matchEngine.currentItem!.superLike();
                    //     },
                    //     child: Text("Superlike")),
                    TextButton(
                        onPressed: () {
                          _matchEngine.currentItem!.like();
                        },
                        child: Image.asset('images/like.png',height: 50,width: 50,))
                  ],
                ),
              ),
            ])
    );
  }


  check(i) async {
    var currentimageuser = Otherlist[i]['email'];
    var data = await _firestore.collection('Users').where(
        'Email', isEqualTo: '$currentimageuser').get();
    List newdata = await data.docs.map((e) => e.data()['Liked']).toList();

    for (int i = 0; i < newdata[0].length; i++) {
      if (newdata[0][i] == user) {
        Mychatcreate(currentimageuser) ;
        print('match foundadhkjasgfgdghjadsadasdad');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Match Found"), //Text("Liked ${[i]}"),
          duration: Duration(milliseconds: 500),
        ));
      }
      else {
        await _firestore.collection('Users').doc('$user').update(
            {'Liked': FieldValue.arrayUnion([currentimageuser])});
      }
    }


    }

Mychatcreate(c) async {
    var N1= await _firestore.collection('Users').doc(user).get().then((value) => value.data()!['Name']);
    var N2 = await _firestore.collection('Users').doc('$c').get().then((value) => value.data()!['Name']);
    await FirebaseFirestore.instance.collection('CHAT$N1$N2').doc().set({'sender': '', 'Text': ''});

  _firestore.collection('Users').doc(user).update({'MYMATCHCHAT': FieldValue.arrayUnion([{'name':'$c','ref':'CHAT$N1$N2'}]) });
    _firestore.collection('Users').doc('$c').update({'MYMATCHCHAT': FieldValue.arrayUnion([{'name':user,'ref':'CHAT$N1$N2'}]) });
}
}

