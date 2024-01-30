/*

This db stores posts that users have published in the app.
It stores in a collection called 'Posts; in Firebase


Each post contain
-a message
-email of user
- timestamp


 */



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase{
  //current logged in user
  User? user=FirebaseAuth.instance.currentUser;

  //get the collection of post from firebase
final CollectionReference posts= FirebaseFirestore.instance.collection('Posts');

  //post a message
Future<void> addPost(String message){
  return posts.add({
    'UserEmail':user!.email,
    'Postmessage':message,
    'Timestamp':Timestamp.now()
  });
}

  //read posts from database

Stream<QuerySnapshot>getPostStream(){
  final postStream= FirebaseFirestore
      .instance.collection('Posts')
      .orderBy('Timestamp',descending: true)
      .snapshots();

  return postStream;
}

}