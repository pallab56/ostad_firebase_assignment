import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/priority_style.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

class PrioritySegmentedSelector extends StatelessWidget {
  final TaskPriority value;
  final ValueChanged<TaskPriority> onChanged;

  const PrioritySegmentedSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: TaskColors.segmentBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (final p in kPriorityOrder)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(p),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: value == p ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: value == p
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    p.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          value == p ? FontWeight.w700 : FontWeight.w500,
                      color:
                          value == p ? TaskColors.navy : TaskColors.slateDark,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}