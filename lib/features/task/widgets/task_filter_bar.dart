import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

enum TaskFilter { all, pending, completed }

class TaskFilterBar extends StatelessWidget {
  final TaskFilter selected;
  final int all, pending, completed;
  final ValueChanged<TaskFilter> onChanged;

  const TaskFilterBar({
    super.key,
    required this.selected,
    required this.all,
    required this.pending,
    required this.completed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          _chip('All', all, TaskFilter.all),
          const SizedBox(width: 8),
          _chip('Pending', pending, TaskFilter.pending),
          const SizedBox(width: 8),
          _chip('Completed', completed, TaskFilter.completed),
        ],
      ),
    );
  }

  Widget _chip(String label, int count, TaskFilter value) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? TaskColors.navy : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: isSelected ? TaskColors.navy : TaskColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : TaskColors.slateDark,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : TaskColors.divider,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : TaskColors.slate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}