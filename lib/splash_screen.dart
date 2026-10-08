import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/sign_in.dart';
import 'package:task_manager_firebase_assignment/common/value/colors.dart';

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
    if(!mounted)return;
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInPage()),(route)=>false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
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
                ),

                SizedBox(height: 12.h),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: 362,
                  child: Column(
                    children: [
                      Text(
                        'Firebase Task Manager',
                        style: TextStyle(
                          color: AppColors.chipColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'A simple task manager powered by flutter and Firestore.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        fontSize: 16,
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
