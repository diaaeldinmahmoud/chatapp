import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/widgets/text_field.dart';
import 'package:chatapp/widgets/button.dart';
import 'package:chatapp/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chatapp/helper/show_snackbar.dart';
import 'package:chatapp/pages/chatpage.dart';

class register extends StatefulWidget {
  register({Key? key}) : super(key: key);
  String id = 'register';

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  String email = '';

  String password = '';

  GlobalKey<FormState> formkey = GlobalKey();

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
                      'Register',
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
                      await registeruser();
                      Navigator.pushNamed(
                        context,
                        Chatpage.id,
                        arguments: email,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showsnackbar(
                          context,
                          text: 'The password provided is too weak.',
                        );
                      } else if (e.code == 'email-already-in-use') {
                        showsnackbar(
                          context,
                          text: 'The account already exists for that email.',
                        );
                      }
                    }
                    isloading = false;
                    setState(() {});
                  }
                },
                text: 'Register',
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
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

  void showsnackbar(BuildContext context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<UserCredential> registeruser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return user;
  }
}
