import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_app/appPages/components/drawer.dart';

void userLogout() async {
  await FirebaseAuth.instance.signOut();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //controller
  final TextEditingController noteController = TextEditingController();

  //get user email
  User? curUser = FirebaseAuth.instance.currentUser;

  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: noteController),
        actions: [ElevatedButton(onPressed: () {}, child: Text('S A V E'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      drawer: MyDrawer(),
      body: Center(child: Text('logged in as: ${curUser?.email ?? "Unknown"}')),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
