import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class FormActions extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final bool loading;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const FormActions({
    super.key,
    required this.label,
    required this.onSave,
    required this.onCancel,
    this.icon,
    this.color = TaskColors.navy,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: loading ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              disabledBackgroundColor: TaskColors.slateLight,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: loading ? null : onCancel,
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: TaskColors.slate,
            ),
          ),
        ),
      ],
    );
  }
}