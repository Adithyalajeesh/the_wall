import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //icon drawer header
          DrawerHeader(child: Icon(Icons.favorite,color:Theme.of(context).colorScheme.inversePrimary ,)),
          //home
         Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(15),
               child: ListTile(
                 leading: Icon(Icons.home,color:Theme.of(context).colorScheme.secondary ,),
                 title: Text("H O M E",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                 onTap: (){
                   //this is already home screen so pop the drawer
                   Navigator.pop(context);
                 },
               ),
             ),

             //profile
             Padding(
               padding: const EdgeInsets.all(15),
               child: ListTile(
                 leading: Icon(Icons.person,color:Theme.of(context).colorScheme.secondary ,),
                 title: Text("P R O F I L E",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                 onTap: (){
                   //this is already home screen so pop the drawer
                   Navigator.pop(context);
                   //navigate to profile page
                   Navigator.pushNamed(context, '/profile_page');

                 },
               ),
             ),
             //user
             Padding(
               padding: const EdgeInsets.all(15),
               child: ListTile(
                 leading: Icon(Icons.group,color:Theme.of(context).colorScheme.secondary ,),
                 title: Text("U S E R S ",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                 onTap: (){
                   //this is already home screen so pop the drawer
                   Navigator.pop(context);
                   //navigate to profile page
                   Navigator.pushNamed(context, '/user_page');
                 },
               ),
             ),
           ],
         ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ListTile(
              leading: Icon(Icons.logout,color:Theme.of(context).colorScheme.secondary ,),
              title: Text("L O G O U T ",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
              onTap: (){
                //this is already home screen so pop the drawer
                Navigator.pop(context);
                //logout
                logout();
              },
            ),
          )

        ],
      ),
    );
  }
}
