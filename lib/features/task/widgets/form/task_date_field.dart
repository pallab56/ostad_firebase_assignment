import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class TaskDateField extends StatelessWidget {
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final bool iconFirst;

  const TaskDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.iconFirst = false,
  });

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.calendar_today_outlined,
        size: 19, color: TaskColors.slate);

    final text = Text(
      DateFormat('MM/dd/yyyy').format(value),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: TaskColors.navy,
      ),
    );

    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: TaskColors.border),
      ),
      child: InkWell(
        onTap: () => _pick(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: iconFirst
              ? Row(children: [icon, const SizedBox(width: 10), text])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [text, icon],
                ),
        ),
      ),
    );
  }
}