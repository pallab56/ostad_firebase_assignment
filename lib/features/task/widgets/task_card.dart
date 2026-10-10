import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle, onEdit, onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final done = task.isCompleted;
    final fmt = DateFormat('MMM d');

    return Opacity(
      opacity: done ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 10, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: TaskColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CheckCircle(checked: done, onTap: onToggle),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _PriorityChip(priority: task.priority),
                          if (done) ...[
                            const SizedBox(width: 6),
                            const _DoneChip(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: TaskColors.navy,
                          decoration: done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: TaskColors.slate,
                        ),
                      ),
                    ],
                  ),
                ),
                _IconBtn(icon: Icons.edit_outlined, onTap: onEdit),
                _IconBtn(icon: Icons.delete_outline_rounded, onTap: onDelete),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: TaskColors.divider),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 34),
              child: Row(
                children: [
                  Icon(
                    done
                        ? Icons.check_circle_outline_rounded
                        : Icons.calendar_today_outlined,
                    size: 14,
                    color: TaskColors.slate,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Due ${fmt.format(task.dueDate)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: TaskColors.slateDark,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.access_time_rounded,
                      size: 14, color: TaskColors.slate),
                  const SizedBox(width: 5),
                  Text(
                    fmt.format(task.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: TaskColors.slate,
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

class _CheckCircle extends StatelessWidget {
  final bool checked;
  final VoidCallback onTap;
  const _CheckCircle({required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: checked ? TaskColors.slateDark : Colors.transparent,
            border: Border.all(
              color: checked ? TaskColors.slateDark : const Color(0xFFCBD5E1),
              width: 2,
            ),
          ),
          child: checked
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}

class _PriorityChip extends StatelessWidget {
  final TaskPriority priority;
  const _PriorityChip({required this.priority});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color fg, bg;

    switch (priority) {
      case TaskPriority.high:
        label = 'High';
        fg = const Color(0xFFE11D48);
        bg = const Color(0xFFFFE4E6);
        break;
      case TaskPriority.medium:
        label = 'Medium';
        fg = const Color(0xFFD97706);
        bg = const Color(0xFFFEF3C7);
        break;
      case TaskPriority.low:
        label = 'Low';
        fg = TaskColors.slate;
        bg = TaskColors.divider;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style:
                TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
          ),
        ],
      ),
    );
  }
}

class _DoneChip extends StatelessWidget {
  const _DoneChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Done',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF16A34A),
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 18, color: TaskColors.slateLight),
      ),
    );
  }
}