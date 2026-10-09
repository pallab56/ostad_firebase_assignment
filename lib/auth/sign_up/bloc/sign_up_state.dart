class SignUpState {
  final String userName;
  final String email;
  final String password;
  final String conPassword;
  final bool isPassVisible;

  SignUpState({
    this.userName = '',
    this.email = '',
    this.password = '',
    this.conPassword = ' ',
    this.isPassVisible = false,
  });

  SignUpState copyWith({
    String? userName,
    String? email,
    String? password,
    String? conPassword,
    bool? isPassVisible,
  }) {
    return SignUpState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      conPassword: conPassword ?? this.conPassword,
      isPassVisible: isPassVisible ?? this.isPassVisible,
    );
  }
}
