
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/faetures/auth/toggle_state.dart';
import 'package:uber_clone/faetures/home/view/pages/home_screen.dart';
import 'package:uber_clone/faetures/home/view/pages/initial_screen.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            return (const Center(
              child: Text("Something went wrong !"),
            ));
          } else if (snapshot.hasData) {
            return const InitialScreen();
          } else {
            return  const ToggleScreen();
          }
        },),
    );
  }
}
