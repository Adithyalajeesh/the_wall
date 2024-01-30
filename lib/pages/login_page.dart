import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';
import '../helper/helper_fuction.dart';


class LoginPage extends StatefulWidget {



  final void Function()? onTap;
  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  Future<void> login() async {
    //show loading circle
    showDialog(context: context, builder: (context)=>Center(
      child: CircularProgressIndicator(),
    ));
    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      //pop loading circle
      if(context.mounted)Navigator.pop(context);
    }on  FirebaseAuthException catch(e){
    Navigator.pop(context);
    //String errorMessage = 'An error occurred during registration';
    //display error message to user
    displayMessageToUser(e.code, context);
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
                    hintText: "email",
                    obsecureText: false,
                    controller: emailTextController),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                    hintText: "password",
                    obsecureText: true,
                    controller: passwordTextController),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                MyButton(text: 'Sign in', onTap: () => login()),
                SizedBox(
                  height: 5,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register here',
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
