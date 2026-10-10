import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class CompletedSwitchCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CompletedSwitchCard({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TaskColors.border),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: TaskColors.navy,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Mark task as done',
                  style: TextStyle(fontSize: 13, color: TaskColors.slate),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: WidgetStateProperty.all(Colors.white),
            trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? TaskColors.navy
                  : TaskColors.border,
            ),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}