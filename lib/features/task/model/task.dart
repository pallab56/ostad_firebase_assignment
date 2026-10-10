import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskPriority { high, medium, low }

class Task {
  final String id;
  final String uid;
  final String title;
  final String description;
  final TaskPriority priority;
  final DateTime dueDate;
  final DateTime createdAt;
  final bool isCompleted;
  final String? course;

  const Task({
    required this.id,
    required this.uid,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.createdAt,
    required this.isCompleted,
    this.course,
  });

  factory Task.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return Task(
      id: doc.id,
      uid: d['uid'] ?? '',
      title: d['title'] ?? '',
      description: d['description'] ?? '',
      priority: TaskPriority.values.firstWhere(
        (p) => p.name == d['priority'],
        orElse: () => TaskPriority.low,
      ),
      dueDate: (d['dueDate'] as Timestamp).toDate(),
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isCompleted: d['isCompleted'] ?? false,
      course: d['course'] as String?,
    );
  }
}