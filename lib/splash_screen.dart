import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/sign_in.dart';
import 'package:task_manager_firebase_assignment/common/value/colors.dart';
import 'package:task_manager_firebase_assignment/common/widget/flutter_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextPage();
  }

  Future<void> _moveToNextPage() async {
    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: reusableFluttericon()),

                SizedBox(height: 12.h),

                reusableTitleDesText(title: 'Firebase Task Manager',desc: 'A simple task manager powered by flutter and Firestore.'),
              ],
            ),

            Positioned(
              bottom: 30.h,
              child: Column(
                children: [
                  SpinKitCircle(color: AppColors.buttonBgColor, size: 32),

                  SizedBox(height: 8.h),
                  Shimmer(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade400,
                        Colors.grey.shade100,
                        Colors.grey.shade400,
                      ],
                      stops: [0.1, 0.5, 0.9],
                    ),
                    child: Text(
                      'Initalizing App',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
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
