import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/common/service/local_notification_service.dart';
import 'package:task_manager_firebase_assignment/common/widget/toast_meassage.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/controller/task_form_controller.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/form_actions.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/form_label.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/priority_chip_selector.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_date_field.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_form_app_bar.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _form = TaskFormController();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_form.validate()) return;
    final title = _form.titleCtrl.text.trim();
    final body = _form.descCtrl.text.trim();
    final error = await _form.save();
    if (!mounted) return;

    if (error != null) {
      AppToast.show(
        context,
        title: 'Could not add task',
        message: error,
        type: ToastType.error,
      );
      return;
    }
    Navigator.pop(context); // close first
    
    try {
      await LocalNotificationsService.showNow(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id per task
        title: '$title added',
        body: body,
      );
    } catch (e) {
      debugPrint('Notification failed: $e'); // never blocks the UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TaskColors.bg,
      appBar: const TaskFormAppBar(title: 'New Task', centerTitle: true),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _form,
          builder: (context, _) => Form(
            key: _form.formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    children: [
                      const FormLabel('Title', uppercase: true),
                      TaskTextField(
                        controller: _form.titleCtrl,
                        hint: 'e.g. Complete Flutter Assignment',
                        maxLength: TaskFormController.titleMaxLength,
                        validator: _form.validateTitle,
                      ),
                      const SizedBox(height: 22),
                      const FormLabel('Notes', uppercase: true),
                      TaskTextField(
                        controller: _form.descCtrl,
                        hint: 'Add details, links, or notes...',
                        minLines: 4,
                        maxLines: 6,
                      ),
                      const SizedBox(height: 22),
                      const FormLabel('Due date', uppercase: true),
                      TaskDateField(
                        value: _form.dueDate,
                        onChanged: _form.setDueDate,
                      ),
                      const SizedBox(height: 22),
                      const FormLabel('Priority', uppercase: true),
                      PriorityChipSelector(
                        value: _form.priority,
                        onChanged: _form.setPriority,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: FormActions(
                    label: 'Save Task',
                    color: TaskColors.indigo,
                    loading: _form.saving,
                    onSave: _save,
                    onCancel: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
