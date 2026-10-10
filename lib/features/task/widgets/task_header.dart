import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';

class TaskHeader extends StatelessWidget {
  final int total;
  final VoidCallback? onSearch;
  final VoidCallback? onFilter;
  final VoidCallback? onLogout; 

  const TaskHeader({
    super.key,
    required this.total,
    this.onSearch,
    this.onFilter,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, MMM d').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tasks',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: TaskColors.navy,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: TaskColors.border,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$total TOTAL',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: TaskColors.slateDark,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Today • $date',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: TaskColors.slate,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search_rounded, color: TaskColors.slateDark),
          ),
          IconButton(
            onPressed: onFilter,
            icon: const Icon(Icons.tune_rounded, color: TaskColors.slateDark),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: onLogout,
            icon: const Icon(Icons.logout_rounded, color: TaskColors.slateDark),
          ),
        ],
      ),
    );
  }
}