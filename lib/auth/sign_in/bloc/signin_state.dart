class SignInState {
  final String email;
  final String password;
  final bool isPassVisible;
  const SignInState({
    this.email='',
    this.password='',
    this.isPassVisible=false,
  });

  SignInState copyWith({String? email , String? password,bool? isPassVisible}){
    return SignInState(
      email: email ?? this.email ,
      password: password ?? this.password,
      isPassVisible: isPassVisible ?? this.isPassVisible,
    );
  }
}
