import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/helper_fuction.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Page'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            displayMessageToUser('something went wrong', context);
          }
          //show loading circle
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //has data
          if (snapShot.hasData == null) {
            return Text(' No data');
          }

          final users = snapShot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
              itemBuilder: (context, index) {
              //individual user
              final user=users[index];

              return ListTile(
                title:Text(user['username']) ,

                subtitle: Text(user['email']),
              );

          });
        },
      ),
    );
  }
}
