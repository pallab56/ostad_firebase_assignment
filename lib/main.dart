import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_bloc.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:task_manager_firebase_assignment/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=>SignInBloc()),
          BlocProvider(create: (_)=>SignUpBloc()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade100,
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
