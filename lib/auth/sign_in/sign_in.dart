import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_bloc.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_event.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_state.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/sign_up_page.dart';
import 'package:task_manager_firebase_assignment/common/value/colors.dart';
import 'package:task_manager_firebase_assignment/common/widget/flutter_icon.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              reusableFluttericon(),

              SizedBox(height: 12.h),

              reusableTitleDesText(
                title: 'Welcome Back',
                desc: 'Sign in to your Firebase Task Manager',
              ),

              SizedBox(height: 18.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reUsableText(text: 'Email Address'),
                          SizedBox(height: 5.h),
                          emailTextField(controller: emailController),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              reUsableText(text: 'Password'),
                              Text(
                                'Forgot PassWord?',
                                style: TextStyle(
                                  color: AppColors.buttonBgColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          passwordTextField(
                            controller: passwordController,
                            isVisible: state.isPassVisible,
                            ontap: () {
                              context.read<SignInBloc>().add(
                                IsPasswordVisibleEvent(!state.isPassVisible),
                              );
                            },
                          ),

                          SizedBox(height: 20.h),

                          reusableButton(
                            buttonName: 'SignIn',
                            onTap: () {
                              if (key.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Form is validate')),
                                );
                                context.read<SignInBloc>().add(
                                  EmailEvent(emailController.text),
                                );
                                context.read<SignInBloc>().add(
                                  PasswordEvent(passwordController.text),
                                );
                              }
                            },
                          ),

                          SizedBox(height: 15.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 80.w,
                                child: Divider(color: Colors.grey.shade300),
                              ),

                              reUsableText(text: 'Or continue with'),

                              SizedBox(
                                width: 80.w,
                                child: Divider(color: Colors.grey.shade300),
                              ),
                            ],
                          ),

                          SizedBox(height: 15.h),

                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 45.h,

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                    SizedBox(width: 5.h),
                                    Text(
                                      "Continue With GooGle",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 50.h),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: AppColors.buttonBgColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
