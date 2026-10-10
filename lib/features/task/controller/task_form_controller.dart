import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/features/task/controller/task_controller.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';

/// Form state shared by the Add and Edit screens.
class TaskFormController extends ChangeNotifier {
  static const int titleMaxLength = 60;

  final Task? task; // null = add mode
  final TaskController _api;
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;

  TaskPriority _priority;
  DateTime _dueDate;
  String? _course;
  bool _isCompleted;
  bool _saving = false;
  bool _disposed = false;

  TaskFormController({this.task, TaskController? api})
      : _api = api ?? TaskController(),
        titleCtrl = TextEditingController(text: task?.title ?? ''),
        descCtrl = TextEditingController(text: task?.description ?? ''),
        _priority = task?.priority ?? TaskPriority.medium,
        _dueDate = task?.dueDate ?? DateTime.now(),
        _course = task?.course,
        _isCompleted = task?.isCompleted ?? false;

  bool get isEdit => task != null;
  TaskPriority get priority => _priority;
  DateTime get dueDate => _dueDate;
  String? get course => _course;
  bool get isCompleted => _isCompleted;
  bool get saving => _saving;

  void setPriority(TaskPriority v) {
    _priority = v;
    notifyListeners();
  }

  void setDueDate(DateTime v) {
    _dueDate = DateTime(v.year, v.month, v.day);
    notifyListeners();
  }

  void setCourse(String? v) {
    _course = v;
    notifyListeners();
  }

  void setCompleted(bool v) {
    _isCompleted = v;
    notifyListeners();
  }

  void reset() {
    titleCtrl.text = task?.title ?? '';
    descCtrl.text = task?.description ?? '';
    _priority = task?.priority ?? TaskPriority.medium;
    _dueDate = task?.dueDate ?? DateTime.now();
    _course = task?.course;
    _isCompleted = task?.isCompleted ?? false;
    formKey.currentState?.reset();
    notifyListeners();
  }

  String? validateTitle(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Title is required' : null;

  bool validate() => formKey.currentState?.validate() ?? false;

  /// Returns null on success, or an error message.
  Future<String?> save() async {
    _setSaving(true);

    final title = titleCtrl.text.trim();
    final description = descCtrl.text.trim();

    final error = isEdit
        ? await _api.updateTask(
            id: task!.id,
            title: title,
            description: description,
            priority: _priority,
            dueDate: _dueDate,
            isCompleted: _isCompleted,
            course: _course,
          )
        : await _api.addTask(
            title: title,
            description: description,
            priority: _priority,
            dueDate: _dueDate,
            course: _course,
          );

    _setSaving(false);
    return error;
  }

  void _setSaving(bool v) {
    _saving = v;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }
}