import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_event.dart';
import 'package:task_manager_firebase_assignment/auth/sign_in/bloc/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<EmailEvent>(_emailHandler);
    on<PasswordEvent>(_passwordHandler);
    on<IsPasswordVisibleEvent>(_visibilityHandler);
  }

  void _emailHandler(EmailEvent event, Emitter<SignInState> emit) {
    debugPrint('signin emailName : ${event.email}');
    emit(state.copyWith(email: event.email));
  }

  void _passwordHandler(PasswordEvent event, Emitter<SignInState> emit) {
    debugPrint('signin password : ${event.password}');
    emit(state.copyWith(password: event.password));
  }

  void _visibilityHandler(
    IsPasswordVisibleEvent event,
    Emitter<SignInState> emit,
  ) {
    debugPrint('signin visiblity : ${event.isPassVisible}');
    emit(state.copyWith(isPassVisible: event.isPassVisible));
  }
}
