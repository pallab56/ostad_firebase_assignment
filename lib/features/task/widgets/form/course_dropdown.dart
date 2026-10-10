import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class CourseDropdown extends StatelessWidget {
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const CourseDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final safeValue = options.contains(value) ? value : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: TaskColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: TaskColors.slate),
          hint: const Text(
            'Select',
            style: TextStyle(fontSize: 15, color: TaskColors.slateLight),
          ),
          onChanged: onChanged,
          items: [
            for (final c in options)
              DropdownMenuItem(
                value: c,
                child: Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: const BoxDecoration(
                        color: TaskColors.navy,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      c,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: TaskColors.navy,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}