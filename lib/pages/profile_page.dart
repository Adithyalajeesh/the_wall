import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_wall_social/components/my_backbutton.dart';
import 'package:the_wall_social/helper/helper_fuction.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});
   //current logged in user
  User? currentUser = FirebaseAuth.instance.currentUser;

   //future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    future: getUserDetails(),
    builder: (context,snapShot){
    if (snapShot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    //error
    if (snapShot.hasError) {
    return Center(
    child: Text('Error: ${snapShot.error}'),
    );
    }
    //get data
    else if(snapShot.hasData){
    Map<String,dynamic>?user= snapShot.data!.data();
    return Center(
      child: Column(

      children: [

        //back button

        Padding(
          padding: const EdgeInsets.only(top: 50,left: 25),
          child: Row(
            children: [
              MybackButton()
            ],
          ),
        ),


        //profile pic
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(24),

          ),
          padding: EdgeInsets.all(25),
          child: Icon(Icons.person,size: 64,),
        ),

        const SizedBox(height: 25,),

        //username
        Text(user!['username'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        const SizedBox(height: 10,),

        //email
      Text(user!['email'],style: TextStyle(color: Colors.grey.shade600),),


      ],
      ),
    );
    }else{
    return Text('No data');
    }

    }
    ),);

  }
}
