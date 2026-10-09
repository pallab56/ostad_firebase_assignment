import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_firebase_assignment/common/value/colors.dart';

Widget reusableFluttericon() {
  return Center(
    child: Container(
      height: 60.h,
      width: 70.w,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Image.asset(
          'android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
          color: AppColors.buttonBgColor,
          alignment: Alignment.center,
          height: 40.h,
          width: 35.w,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

Container reusableTitleDesText({required String title, required String desc}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30),
    width: 362,
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.chipColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );
}

TextFormField emailTextField({required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email Is Required';
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid Email Address';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: 'user@gmail.com',
      prefixIcon: Icon(
        Icons.email_outlined,
        size: 22,
        color: Colors.black.withValues(alpha: 0.4),
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}

TextFormField passwordTextField({
  required TextEditingController controller,
  required bool isVisible,
  VoidCallback? ontap,
}) {
  return TextFormField(
    controller: controller,
    onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      if (!RegExp(r'[A-Z]').hasMatch(value)) {
        return 'Add at least one uppercase letter';
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        return 'Add at least one lowercase letter';
      }
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Add at least one number';
      }
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-]').hasMatch(value)) {
        return 'Add at least one special character';
      }
      return null;
    },
    obscureText: isVisible,
    decoration: InputDecoration(
      hintText: 'password',
      prefixIcon: Icon(
        Icons.lock_outline,
        size: 22,
        color: Colors.black.withValues(alpha: 0.4),
      ),
      suffixIcon: GestureDetector(
        onTap: ontap,
        child: isVisible
            ? Icon(
                Icons.visibility_off,
                size: 22,
                color: Colors.black.withValues(alpha: 0.4),
              )
            : Icon(
                Icons.visibility,
                size: 22,
                color: Colors.black.withValues(alpha: 0.4),
              ),
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),
  );
}

Widget reusableButton({required String buttonName, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: AppColors.buttonBgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              buttonName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5.h),
            Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

Text reUsableText({required String text}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade600,
    ),
  );
}
