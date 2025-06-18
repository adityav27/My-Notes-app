import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user's UID, or throw if not logged in.
  String get userId {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user. Please log in.');
    }
    return user.uid;
  }

  /// Reference to `users/{userId}/notes` collection.
  /// locating the users notes
  CollectionReference<Map<String, dynamic>> get _notesRef {
    return _firestore.collection('users').doc(userId).collection('notes');
  }

  /// Add a new note.
  /// Returns the new document ID on success.
  Future<String> addNote({
    required String heading,
    required String content,
  }) async {
    try {
      final now = FieldValue.serverTimestamp();
      final docRef = await _notesRef.add({
        'heading': heading,
        'content': content,
        'createdAt': now,
      });
      return docRef.id;
    } on FirebaseException catch (e) {
      //error
      throw Exception('Failed to add note: ${e.message}');
    }
  }

  /// get notes
  /// Stream all notes for current user, ordered by createdAt descending.
  Stream<QuerySnapshot<Map<String, dynamic>>> getNotesStream() {
    // Note: if user signs out, this may throw because userId getter will throw.
    return _notesRef.orderBy('createdAt', descending: true).snapshots();
  }

  /// Update a note by ID.
  Future<void> updateNote({
    required String noteId,
    required String newHeading,
    required String newContent,
  }) async {
    try {
      await _notesRef.doc(noteId).update({
        'heading': newHeading,
        'content': newContent,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      // error
      throw Exception('Failed to update note: ${e.message}');
    }
  }

  /// Delete a note by ID.
  Future<void> deleteNote({required String noteId}) async {
    try {
      await _notesRef.doc(noteId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete note: ${e.message}');
    }
  }
}
