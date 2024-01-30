import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_wall_social/components/list_tile.dart';
import 'package:the_wall_social/components/my_drawer.dart';
import 'package:the_wall_social/components/my_post_button.dart';
import 'package:the_wall_social/components/text_field.dart';
import 'package:the_wall_social/database/firestore.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

   final FirestoreDatabase database= FirestoreDatabase();

  final TextEditingController newPostController= TextEditingController();


  //logout user
  void logout(){
    FirebaseAuth.instance.signOut();
  }
//post message

  void postMessage(){
    //post!! only if something is there in the text field
    if(newPostController.text.isNotEmpty){
      String message= newPostController.text;
      database.addPost(message);

    }
    //clear message
   newPostController.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(

        title: Center(child: Text('W A L L',style: TextStyle(fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,

        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:IconButton(
              onPressed: logout,
              icon: Icon(Icons.logout),
            )
          )
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(height:10 ,),
          //text field box for users to input the post

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(hintText: 'Say something...',
                      obsecureText: false,
                      controller: newPostController),
                ),
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          SizedBox(height: 25,),
          StreamBuilder(
              stream: database.getPostStream(),
              builder: (context,snapshot){
                //show loading circle
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }


                //get all posts
                final posts=snapshot.data!.docs;

                //no data?
                if(snapshot.data==null||posts.isEmpty){
                  return const Center(
                    child:  Padding(padding: EdgeInsets.all(25),
                      child: Text('No Posts!!! Post something..'),
                    ),
                  );
                }

                //return a list
                return Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                        itemBuilder: (context,index){
                        //get each individual posts
                          final post =posts[index];

                          //get data from each posts
                          String message=post['Postmessage'];
                          String userEmail=post['UserEmail'];
                          Timestamp timestamp=post['Timestamp'];

                          //return as a list tile
                          return MyListTile(title: message, subTitle: userEmail);
                        }
                    ));

              },
              )
        ],
      ),
    );
  }
}
