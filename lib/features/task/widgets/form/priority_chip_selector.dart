import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/priority_style.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

class PriorityChipSelector extends StatelessWidget {
  final TaskPriority value;
  final ValueChanged<TaskPriority> onChanged;

  const PriorityChipSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < kPriorityOrder.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(
            child: _Chip(
              priority: kPriorityOrder[i],
              selected: value == kPriorityOrder[i],
              onTap: () => onChanged(kPriorityOrder[i]),
            ),
          ),
        ],
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final TaskPriority priority;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.priority,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 44,
        decoration: BoxDecoration(
          color: selected ? priority.softBg : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? priority.ring : TaskColors.border,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                color: priority.dot,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              priority.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? priority.strongText : TaskColors.slateDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}