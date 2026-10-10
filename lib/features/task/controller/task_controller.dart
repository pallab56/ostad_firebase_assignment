import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

/// The only file that talks to Firestore.
class TaskController {
  final CollectionReference<Map<String, dynamic>> _tasks = FirebaseFirestore
      .instance
      .collection('tasks');

  /// null when nobody is signed in
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Stream<List<Task>> watchTasks() {
    final uid = _uid;
    if (uid == null) return Stream.value(<Task>[]);

    return _tasks.where('uid', isEqualTo: uid).snapshots().map((snap) {
      final list = snap.docs.map(Task.fromDoc).toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // newest first
      return list;
    });
  }

  Future<String?> addTask({
    required String title,
    required String description,
    required TaskPriority priority,
    required DateTime dueDate,
    String? course,
  }) {
    final uid = _uid;
    if (uid == null) return Future.value('Please sign in first.');

    return _guard('Could not add task.', () async {
      await _tasks.add({
        'uid': uid,
        'title': title,
        'description': description,
        'priority': priority.name,
        'dueDate': Timestamp.fromDate(dueDate),
        'createdAt': FieldValue.serverTimestamp(),
        'isCompleted': false,
        'course': course,
      });
    });
  }

  Future<String?> updateTask({
    required String id,
    required String title,
    required String description,
    required TaskPriority priority,
    required DateTime dueDate,
    required bool isCompleted,
    String? course,
  }) {
    return _guard('Could not update task.', () async {
      await _tasks.doc(id).update({
        'title': title,
        'description': description,
        'priority': priority.name,
        'dueDate': Timestamp.fromDate(dueDate),
        'isCompleted': isCompleted,
        'course': course,
      });
    });
  }

  Future<String?> toggleComplete(Task task) {
    return _guard('Could not update task.', () async {
      await _tasks.doc(task.id).update({'isCompleted': !task.isCompleted});
    });
  }

  Future<String?> deleteTask(String id) {
    return _guard('Could not delete task.', () async {
      await _tasks.doc(id).delete();
    });
  }

  /// Returns null on success, or an error message.
  Future<String?> _guard(
    String fallback,
    Future<void> Function() action,
  ) async {
    try {
      await action();
      return null;
    } on FirebaseException catch (e) {
      return e.message ?? fallback;
    } on TimeoutException {
      return 'Could not reach the server. Check your internet and Firestore rules.';
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }
}
