abstract class SignInEvent {}

class EmailEvent extends SignInEvent {
  String email;
  EmailEvent(this.email);
}

class PasswordEvent extends SignInEvent {
  String password;
  PasswordEvent(this.password);
}

class IsPasswordVisibleEvent extends SignInEvent {
  bool isPassVisible;
  IsPasswordVisibleEvent(this.isPassVisible);
}
