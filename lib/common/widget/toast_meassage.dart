import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, warning, info }

class AppToast {

static void showMessage({required String msg}){
   Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
}



// custom required context
  static void show(
   {
    required String title,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final fToast = FToast()..init;
    final config = _config(type);

    fToast.removeQueuedCustomToasts(); // avoid stacking old toasts

    fToast.showToast(
      gravity: ToastGravity.TOP,
      toastDuration: duration,
      
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: config.color.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: config.color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(config.icon, color: config.color, size: 22),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
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

  static _ToastConfig _config(ToastType type) {
    switch (type) {
      case ToastType.success:
        return _ToastConfig(Colors.green, Icons.check_circle_rounded);
      case ToastType.error:
        return _ToastConfig(Colors.red, Icons.error_rounded);
      case ToastType.warning:
        return _ToastConfig(Colors.orange, Icons.warning_rounded);
      case ToastType.info:
        return _ToastConfig(Colors.blue, Icons.info_rounded);
    }
  }
}

class _ToastConfig {
  final Color color;
  final IconData icon;
  _ToastConfig(this.color, this.icon);
}