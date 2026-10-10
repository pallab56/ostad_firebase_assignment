import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

extension PriorityStyle on TaskPriority {
  String get label => switch (this) {
        TaskPriority.low => 'Low',
        TaskPriority.medium => 'Medium',
        TaskPriority.high => 'High',
      };

  Color get dot => switch (this) {
        TaskPriority.low => const Color(0xFF10B981),
        TaskPriority.medium => const Color(0xFFF59E0B),
        TaskPriority.high => const Color(0xFFF43F5E),
      };

  Color get softBg => switch (this) {
        TaskPriority.low => const Color(0xFFECFDF5),
        TaskPriority.medium => const Color(0xFFFFFBEB),
        TaskPriority.high => const Color(0xFFFFF1F2),
      };

  Color get ring => switch (this) {
        TaskPriority.low => const Color(0xFF6EE7B7),
        TaskPriority.medium => const Color(0xFFFCD34D),
        TaskPriority.high => const Color(0xFFFDA4AF),
      };

  Color get strongText => switch (this) {
        TaskPriority.low => const Color(0xFF065F46),
        TaskPriority.medium => const Color(0xFF92400E),
        TaskPriority.high => const Color(0xFF9F1239),
      };
}

/// Display order in the UI.
const kPriorityOrder = [
  TaskPriority.low,
  TaskPriority.medium,
  TaskPriority.high,
];