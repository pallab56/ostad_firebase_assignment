import 'package:flutter/material.dart';
import 'package:task_manager_firebase_assignment/common/widget/toast_meassage.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/course_options.dart';
import 'package:task_manager_firebase_assignment/features/task/constants/task_colors.dart';
import 'package:task_manager_firebase_assignment/features/task/controller/task_form_controller.dart';
import 'package:task_manager_firebase_assignment/features/task/model/task.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/completed_switch_card.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/course_dropdown.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/form_actions.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/form_label.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/priority_segmented_selector.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_date_field.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_form_app_bar.dart';
import 'package:task_manager_firebase_assignment/features/task/widgets/form/task_text_field.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;

  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TaskFormController _form = TaskFormController(task: widget.task);

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Future<void> _save() async {
  FocusScope.of(context).unfocus();
  if (!_form.validate()) return;

  final error = await _form.save();
  if (!mounted) return;

  if (error != null) {
    AppToast.show(
      context,
      title: 'Could not update task',
      message: error,
      type: ToastType.error,
    );
    return;
  }

  Navigator.pop(context); // close first
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TaskColors.bg,
      appBar: TaskFormAppBar(
        title: 'Edit Task',
        action: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: _form.reset,
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: TaskColors.slateLight,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _form,
          builder: (context, _) => Form(
            key: _form.formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                FormLabel(
                  'Task Title',
                  trailing: CharCounter(
                    controller: _form.titleCtrl,
                    max: TaskFormController.titleMaxLength,
                  ),
                ),
                TaskTextField(
                  controller: _form.titleCtrl,
                  maxLength: TaskFormController.titleMaxLength,
                  clearable: true,
                  validator: _form.validateTitle,
                ),
                const SizedBox(height: 20),
                const FormLabel('Description & Milestones'),
                TaskTextField(
                  controller: _form.descCtrl,
                  minLines: 4,
                  maxLines: 6,
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormLabel('Due Date'),
                          TaskDateField(
                            value: _form.dueDate,
                            onChanged: _form.setDueDate,
                            iconFirst: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormLabel('Course Bucket'),
                          CourseDropdown(
                            value: _form.course,
                            options: kCourseOptions,
                            onChanged: _form.setCourse,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const FormLabel('Priority'),
                PrioritySegmentedSelector(
                  value: _form.priority,
                  onChanged: _form.setPriority,
                ),
                const SizedBox(height: 20),
                CompletedSwitchCard(
                  value: _form.isCompleted,
                  onChanged: _form.setCompleted,
                ),
                const SizedBox(height: 28),
                FormActions(
                  label: 'Save Changes',
                  icon: Icons.check_rounded,
                  loading: _form.saving,
                  onSave: _save,
                  onCancel: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}