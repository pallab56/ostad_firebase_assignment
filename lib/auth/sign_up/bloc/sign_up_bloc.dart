import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_event.dart';
import 'package:task_manager_firebase_assignment/auth/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<UserNameRegisterEvent>(_userNameRegHandler);
    on<EmailRegisterEvent>(_emailRegHandler);
    on<PasswordRegisterEvent>(_passwordRegHandler);
    on<ConPassRegisterEvent>(_conPasswordRegHandler);
    on<IsPassVisibleRegisterEvent>(_visiblityRegHandler);
  }

  void _userNameRegHandler(
    UserNameRegisterEvent event,
    Emitter<SignUpState> emit,
  ) {
    debugPrint('reg UserName : ${event.userName}');
    emit(state.copyWith(userName: event.userName));
  }

  void _emailRegHandler(EmailRegisterEvent event, Emitter<SignUpState> emit) {
    debugPrint('reg emailName : ${event.email}');
    emit(state.copyWith(email: event.email));
  }

  void _passwordRegHandler(
    PasswordRegisterEvent event,
    Emitter<SignUpState> emit,
  ) {
    debugPrint('reg password : ${event.password}');
    emit(state.copyWith(password: event.password));
  }

  void _conPasswordRegHandler(
    ConPassRegisterEvent event,
    Emitter<SignUpState> emit,
  ) {
    debugPrint('reg conPass : ${event.conPassword}');
    emit(state.copyWith(conPassword: event.conPassword));
  }

  void _visiblityRegHandler(
    IsPassVisibleRegisterEvent event,
    Emitter<SignUpState> emit,
  ) {
    debugPrint('reg visiBlity : ${event.isPassVisible}');
    emit(state.copyWith(isPassVisible: event.isPassVisible));
  }
}
