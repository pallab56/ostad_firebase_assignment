abstract class SignUpEvent {}

class UserNameRegisterEvent extends SignUpEvent {
  String userName;
  UserNameRegisterEvent(this.userName);
}

class EmailRegisterEvent extends SignUpEvent {
  String email;
  EmailRegisterEvent(this.email);
}
class PasswordRegisterEvent extends SignUpEvent {
  String password;
  PasswordRegisterEvent(this.password);
}
class ConPassRegisterEvent extends SignUpEvent {
  String conPassword;
  ConPassRegisterEvent(this.conPassword);
}
class IsPassVisibleRegisterEvent extends SignUpEvent {
  bool isPassVisible;
  IsPassVisibleRegisterEvent(this.isPassVisible);
}



