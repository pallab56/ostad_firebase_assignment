import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/auth/service/firebase_atuh_service.dart';
import 'package:task_manager_firebase_assignment/common/widget/toast_meassage.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/controller/task_controller.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';
import 'package:task_manager_firebase_assignment/features/task/view/add_task_screen.dart';
import 'package:task_manager_firebase_assignment/features/task/view/edit_task_screen.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/task_card.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/task_filter_bar.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/task_header.dart';

import 'package:task_manager_firebase_assignment/features/auth/sign_in/sign_in.dart';

class TaskListScreen extends StatefulWidget {
  String? payload;
  TaskListScreen({this.payload = 'Notihing In payload' ,super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _controller = TaskController();
  late final Stream<List<Task>> _stream = _controller.watchTasks();
  TaskFilter _filter = TaskFilter.all;

  List<Task> _applyFilter(List<Task> tasks) {
    switch (_filter) {
      case TaskFilter.pending:
        return tasks.where((t) => !t.isCompleted).toList();
      case TaskFilter.completed:
        return tasks.where((t) => t.isCompleted).toList();
      case TaskFilter.all:
        return tasks;
    }
  }

  Future<void> _run(Future<String?> action) async {
    final error = await action;
    if (!mounted || error == null) return;
    AppToast.show(
      context,
      title: 'Error',
      message: error,
      type: ToastType.error,
    );
  }

  void _openAdd()async {
   await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (!mounted) return;
  AppToast.show(context,
      title: 'Task added',
      message: 'Your task has been saved',
      type: ToastType.success);
  }

  void _openEdit(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditTaskScreen(task: task)),
    );
  }

  Future<void> _confirmDelete(Task task) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Delete task?'),
        content: Text('"${task.title}" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (ok == true) _run(_controller.deleteTask(task.id));
  }

  Future<void> _confirmLogout() async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Sign out?'),
      content: const Text('You will need to sign in again to see your tasks.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Sign out', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );

  if (ok != true) return;

  await FirebaseAuthhService.logOut();
  if (!mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const SignInPage()),
    (route) => false,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TaskColors.bg,
      body: SafeArea(
        child: StreamBuilder<List<Task>>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('${snapshot.error}'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final all = snapshot.data!;
            final pending = all.where((t) => !t.isCompleted).length;
            final tasks = _applyFilter(all);

            return Column(
              children: [
                TaskHeader(total: all.length,onLogout: _confirmLogout),
                TaskFilterBar(
                  selected: _filter,
                  all: all.length,
                  pending: pending,
                  completed: all.length - pending,
                  onChanged: (f) => setState(() => _filter = f),
                ),
                Expanded(
                  child: tasks.isEmpty
                      ? const Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(color: TaskColors.slate),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                          itemCount: tasks.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 14),
                          itemBuilder: (_, i) {
                            final task = tasks[i];
                            return TaskCard(
                              task: task,
                              onToggle: () =>
                                  _run(_controller.toggleComplete(task)),
                              onEdit: () => _openEdit(task),
                              onDelete: () => _confirmDelete(task),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        backgroundColor: TaskColors.navy,
        shape: const StadiumBorder(),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}