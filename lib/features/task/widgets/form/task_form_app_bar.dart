import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class TaskFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Widget? action;

  const TaskFormAppBar({
    super.key,
    required this.title,
    this.centerTitle = false,
    this.action,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TaskColors.bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      titleSpacing: centerTitle ? null : 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded, color: TaskColors.slateDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: TaskColors.navy,
        ),
      ),
      actions: [if (action != null) action!],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: TaskColors.border),
      ),
    );
  }
}