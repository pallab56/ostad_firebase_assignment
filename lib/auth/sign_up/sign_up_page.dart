import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/sign_in.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_event.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_state.dart';
import 'package:task_manager_firebase_assignment/common/value/colors.dart';
import 'package:task_manager_firebase_assignment/common/widget/flutter_icon.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    conPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,

          title: Text('SIgn Up'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * .1),
                      Center(
                        child: Text(
                          "Enter Your Details below and free signUp.",
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Form(
                          key: key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reUsableText(text: "User Name"),
                              SizedBox(height: 5.h),
                              TextFormField(
                                controller: userNameController,
                                onTapOutside: (event) => FocusManager
                                    .instance
                                    .primaryFocus!
                                    .unfocus(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'user Name Is Required';
                                  }

                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'User Name',
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 22,
                                    color: Colors.black.withValues(alpha: 0.4),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 5.h),
                              reUsableText(text: "Email"),
                              SizedBox(height: 5.h),
                              emailTextField(controller: emailController),

                              SizedBox(height: 5.h),
                              reUsableText(text: "PassWord"),
                              SizedBox(height: 5.h),
                              passwordTextField(
                                controller: passwordController,
                                isVisible: state.isPassVisible,
                                ontap: () {
                                  context.read<SignUpBloc>().add(
                                    IsPassVisibleRegisterEvent(
                                      !state.isPassVisible,
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 5.h),
                              reUsableText(text: "Confirm Password"),
                              SizedBox(height: 5.h),
                              passwordTextField(
                                controller: conPasswordController,
                                isVisible: state.isPassVisible,
                                ontap: () {
                                  context.read<SignUpBloc>().add(
                                    IsPassVisibleRegisterEvent(
                                      !state.isPassVisible,
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 5.h),
                              reUsableText(
                                text: 'By creating an account you have to aggree with our trems & condition',
                              ),
                              SizedBox(height: 15.h),
                              reusableButton(
                                buttonName: 'Create an Account',
                                onTap: () {
                                  if (key.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Form is validate'),
                                      ),
                                    );
                                    context.read<SignUpBloc>().add(
                                      UserNameRegisterEvent(userNameController.text),
                                    );
                                    context.read<SignUpBloc>().add(
                                      EmailRegisterEvent(emailController.text),
                                    );
                                    context.read<SignUpBloc>().add(
                                      PasswordRegisterEvent(passwordController.text),
                                    );
                                     context.read<SignUpBloc>().add(
                                      ConPassRegisterEvent(conPasswordController.text),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 50.h),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInPage(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    Text(
                                      'Sign In',
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
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
