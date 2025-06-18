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

  // Dialog box to write notes
  void openNoteBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'A D D  Y O U R  N O T E',
          style: TextStyle(fontSize: 20),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: headingController,
                decoration: const InputDecoration(hintText: 'Enter a title'),
                maxLines: 1,
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Enter note content',
                ),
                maxLines: 100,
              ),
            ],
          ),
        ),

        actions: [
          ElevatedButton(
            onPressed: () async {
              final heading = headingController.text.trim();
              final content = noteController.text.trim();

              if (heading.isEmpty && content.isEmpty) {
                // optional: show a message or just return
                return;
              }

              try {
                await FirestoreService().addNote(
                  heading: heading,
                  content: content,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note added successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }

              // Clear controllers
              headingController.clear();
              noteController.clear();
              // Close dialog
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
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Image.asset('assets/fire1.png', width: 50),
          ),
        ],
        title: Text(
          'F I R E   N O T E S',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirestoreService().getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notes yet."));
          }

          final notes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final docSnap = notes[index];
              final data = docSnap.data();
              final noteId = docSnap.id;

              // Parse createdAt if present
              DateTime? createdAt;
              if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
                createdAt = (data['createdAt'] as Timestamp).toDate().toLocal();
              }
              // Split into date/time strings
              String dateString = '';
              String timeString = '';
              if (createdAt != null) {
                final parts = createdAt.toString().split(' ');
                dateString = parts.isNotEmpty ? parts[0] : '';
                if (parts.length > 1) {
                  timeString = parts[1].split('.')[0];
                }
              }

              return myCard(
                data,
                context,
                noteId,
                createdAt,
                dateString,
                timeString,
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
    );
  }

  Card myCard(
    Map<String, dynamic> data,
    BuildContext context,
    String noteId,
    DateTime? createdAt,
    String dateString,
    String timeString,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: heading and content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['heading'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['content'] as String? ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Right: edit/delete icons and date/time on separate lines
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () {
                        // TODO: open edit dialog, passing noteId and data
                        openEditNoteBox(
                          context,
                          noteId,
                          data['heading'] ?? '',
                          data['content'] ?? '',
                        );
                      },
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () async {
                        // Optional: confirm deletion
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Note'),
                            content: const Text(
                              'Are you sure you want to delete this note?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('CANCEL'),
                              ),
                              ElevatedButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('DELETE'),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          try {
                            await FirestoreService().deleteNote(noteId: noteId);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Note deleted')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error deleting note: $e'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
                if (createdAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    dateString,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    timeString,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//editing dialog box

void openEditNoteBox(
  BuildContext context,
  String noteId,
  String initialHeading,
  String initialContent,
) {
  final headingController = TextEditingController(text: initialHeading);
  final contentController = TextEditingController(text: initialContent);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit Note'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: headingController,
              decoration: const InputDecoration(hintText: 'Enter a title'),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(hintText: 'Enter note content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: () async {
            final newHeading = headingController.text.trim();
            final newContent = contentController.text.trim();

            if (newHeading.isEmpty || newContent.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Both fields are required')),
              );
              return;
            }

            try {
              await FirestoreService().updateNote(
                noteId: noteId,
                newHeading: newHeading,
                newContent: newContent,
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Note updated')));
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
          child: const Text('SAVE'),
        ),
      ],
    ),
  );
}
