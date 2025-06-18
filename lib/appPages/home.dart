import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes_app/appPages/components/drawer.dart';
import 'package:my_notes_app/pages/firebase.dart';

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
  final TextEditingController headingController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  //get user email
  User? curUser = FirebaseAuth.instance.currentUser;

  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: Column(
          children: [
            TextField(
              controller: headingController,
              decoration: const InputDecoration(hintText: 'Enter a title'),
              maxLines: 1,
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(hintText: 'Enter note content'),
              maxLines: null,
            ),
          ],
        ),

        actions: [
          ElevatedButton(
            onPressed: () {
              //add note

              //clear controller
              noteController.clear();
              //pop it
              Navigator.pop(context);
            },
            child: Text('S A V E'),
          ),
        ],
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
