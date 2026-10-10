import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class FormLabel extends StatelessWidget {
  final String text;
  final bool uppercase;
  final Widget? trailing;

  const FormLabel(this.text, {super.key, this.uppercase = false, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            uppercase ? text.toUpperCase() : text,
            style: uppercase
                ? const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: TaskColors.slate,
                  )
                : const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: TaskColors.slate,
                  ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// "27/60" counter that updates as the user types.
class CharCounter extends StatelessWidget {
  final TextEditingController controller;
  final int max;

  const CharCounter({super.key, required this.controller, required this.max});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, value, __) => Text(
        '${value.text.length}/$max',
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'monospace',
          color: TaskColors.slateLight,
        ),
      ),
    );
  }
}