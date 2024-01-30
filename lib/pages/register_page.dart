import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';
import '../helper/helper_fuction.dart';


class RegisterPage extends StatefulWidget {
  final void Function() onTap;
  RegisterPage({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  Future<void> register() async {
    //show loading circle
    showDialog(context: context, builder: (context)=>const Center(
      child: CircularProgressIndicator(),
    ));

    // make sure password match
    if (passwordTextController.text != confirmPasswordTextController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error message to user
      displayMessageToUser('Passwords don\'t match', context);
    }

    else{
    //try creating the user
    try{
  UserCredential? userCredential=
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailTextController.text, 
      password: passwordTextController.text);
  //create a user document and add it into firestore
  createUserDocument(userCredential);




  if(context.mounted)Navigator.pop(context);
      
    }on FirebaseAuthException catch(e){
  Navigator.pop(context);
  String errorMessage = 'An error occurred during registration';

  if (e.code == 'weak-password') {
    errorMessage = 'The password provided is too weak.';
  } else if (e.code == 'email-already-in-use') {
    errorMessage = 'The account already exists for that email.';
  } else if (e.code == 'invalid-email') {
    errorMessage = 'The email address is not valid.';
  } else {
    errorMessage = 'Error code: ${e.code}';
  }
     //display error message to user
      displayMessageToUser(errorMessage, context);
    }}
  }
  //create a user document and collect them in firestore
  Future<void>createUserDocument(UserCredential?userCredential)async{
    if(userCredential!=null&&userCredential.user!=null){
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.email).set(
          {'email':userCredential.user!.email,
            'username': userNameTextController.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                ),
                //logo
                Icon(
                  Icons.person,
                  size: 80,
                ),

                //app name
                Text(
                  'M I N I M A L',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                //textfield
                MyTextField(
                    hintText: "username",
                    obsecureText: false,
                    controller: userNameTextController),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: "email",
                    obsecureText: false,
                    controller: emailTextController),

                SizedBox(
                  height: 5,
                ),
                MyTextField(
                    hintText: "password",
                    obsecureText: true,
                    controller: passwordTextController),

                SizedBox(
                  height: 5,
                ),
                MyTextField(
                    hintText: "Confirm password",
                    obsecureText: true,
                    controller: confirmPasswordTextController),

                SizedBox(
                  height: 5,
                ),
                MyButton(text: 'Sign up', onTap: () => register()),
                SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login here',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
