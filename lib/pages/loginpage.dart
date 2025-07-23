import 'package:flutter/material.dart';
import 'package:chatapp/widgets/text_field.dart';
import 'package:chatapp/widgets/button.dart';
import 'package:chatapp/pages/registerscreen.dart';
import 'package:chatapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snackbar.dart';
import 'chatpage.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormState> formkey = GlobalKey();
  String email = '';

  String password = '';

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: kPrimarycolor,
        body: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(height: 100),
              Image.asset(
                'assets/images/scholar.png',
                height: 100,
                alignment: Alignment.center,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              customtextfield(
                onChanged: (value) {
                  email = value;
                },

                hinttext: 'Email',
              ),
              SizedBox(height: 10),
              customtextfield(
                onChanged: (value) {
                  password = value;
                },
                hinttext: 'Password',
              ),
              SizedBox(height: 20),
              custombutton(
                ontap: () async {
                  if (formkey.currentState!.validate()) {
                    isloading = true;
                    setState(() {});
                    try {
                      await loginuser();
                      Navigator.pushNamed(
                        context,
                        Chatpage.id,
                        arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      isloading = false;
                      setState(() {});
                      if (e.code == 'wrong-password') {
                        print("Wrong password");
                        showsnackbar(
                          context,
                          text: 'The password provided is wrong.',
                        );
                      } else if (e.code == 'user-not-found') {
                        showsnackbar(
                          context,
                          text: 'No user found for that email.',
                        );
                      }
                    }
                    isloading = false;
                    setState(() {});
                  }
                },
                text: 'LOGIN',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, register().id);
                    },
                    child: Text(
                      ' Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<UserCredential> loginuser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user;
  }
}
