import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

void userLogout() async {
  await FirebaseAuth.instance.signOut();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? curUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              userLogout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text('logged in as: ${curUser?.email ?? "Unknown"}')),
    );
  }
}
