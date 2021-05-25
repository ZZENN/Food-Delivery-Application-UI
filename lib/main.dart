import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/screens/home_screen.dart';
import 'package:flutter_food_delivery_ui/screens/login_screen.dart';
import 'package:flutter_food_delivery_ui/constants.dart';
import 'package:flutter_food_delivery_ui/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'STX Door Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.white, selectionHandleColor: Colors.white),
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Constants.white),
          ),
        ),
        initialRoute: LoginScreen.idScreen,
        routes: {
          LoginScreen.idScreen: (context) => LoginScreen(),
          RegisterScreen.idScreen: (context) => RegisterScreen(),
          HomeScreen.idScreen: (context) => HomeScreen(),
        });
  }
}
