import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager_firebase_assignment/features/task/view/task_list_screen.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void openDetails(String payload) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => TaskListScreen(payload: payload,)),
    );
  }
}
