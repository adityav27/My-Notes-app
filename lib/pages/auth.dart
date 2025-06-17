import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes_app/appPages/home.dart';
import 'package:my_notes_app/pages/welcome.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('AuthPage rebuild'); // Prints each time AuthPage rebuilds
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          debugPrint('StreamBuilder called');
          debugPrint('connectionState: ${snapshot.connectionState}');
          debugPrint('hasData (is User present?): ${snapshot.hasData}');
          debugPrint('User (if present): ${snapshot.data?.email}');

          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Still waiting for auth state');
            return Center(child: CircularProgressIndicator()); // Loading
          }
          if (snapshot.hasData) {
            debugPrint('User is authenticated');
            return HomePage();
          }
          debugPrint('User is NOT authenticated');
          return LoginPage();
        },
      ),
    );
  }
}
