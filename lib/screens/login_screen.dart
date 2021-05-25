import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/widgets/progressDialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_input_border/gradient_input_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_food_delivery_ui/screens/login_screen.dart';
import 'package:flutter_food_delivery_ui/screens/register_screen.dart';
import '../constants.dart';
import '../main.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Constants.black_s3, width: 4),
    );
    var textStyle = TextStyle(fontSize: 18);
    var linearGradient = LinearGradient(
      colors: [Constants.purple_pink, Constants.pink],
    );
    var gradientOutlineInputBorder = GradientOutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
      focusedGradient: linearGradient,
      unfocusedGradient: LinearGradient(
        colors: [Constants.black_s3, Constants.black_s3],
      ),
    );
    var textStyle2 = TextStyle(color: Colors.white, fontSize: 18);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.black_s1,
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      decoration: boxDecoration,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 26.0,
                      )),
                  const SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    "Log in",
                    style:
                        TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Email',
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: emailTextEditingController,
                style: textStyle2,
                decoration: InputDecoration(
                    hintText: 'Enter your email',
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 16.0),
                    fillColor: Constants.black_s2,
                    border: gradientOutlineInputBorder),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: textStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordTextEditingController,
                style: textStyle2,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 25.0, horizontal: 16.0),
                    fillColor: Constants.black_s2,
                    border: gradientOutlineInputBorder),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  if (!emailTextEditingController.text.contains("@")) {
                    displayToastMessage("Email address is not Valid.", context);
                  } else if (passwordTextEditingController.text.isEmpty) {
                    displayToastMessage("Password is Mandatory.", context);
                  } else {
                    loginAndAuthenticateUser(context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      gradient: linearGradient),
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white54, fontSize: 16.0),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating, Please wait...",
          );
        });

    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false);
          displayToastMessage("You are logged in.", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists for this user. Please create new account.",
              context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("Error Occured, can not be Signed-in.", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
