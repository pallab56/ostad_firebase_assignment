import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class TaskTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool clearable;
  final String? Function(String?)? validator;

  const TaskTextField({
    super.key,
    required this.controller,
    this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.clearable = false,
    this.validator,
  });

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, value, __) => TextFormField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: TaskColors.navy,
        ),
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: TaskColors.slateLight,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          border: _border(TaskColors.border),
          enabledBorder: _border(TaskColors.border),
          focusedBorder: _border(TaskColors.slate, 1.3),
          errorBorder: _border(Colors.red.shade300),
          focusedErrorBorder: _border(Colors.red.shade400, 1.3),
          suffixIcon: clearable && value.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded,
                      size: 18, color: TaskColors.slateLight),
                  onPressed: controller.clear,
                )
              : null,
        ),
      ),
    );
  }
}