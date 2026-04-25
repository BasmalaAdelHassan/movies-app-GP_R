abstract class AuthEvent {}

class GoogleLoginEvent extends AuthEvent {}

class TogglePasswordVisibilityEvent extends AuthEvent {}

class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  LoginSubmittedEvent({required this.email, required this.password});
}

class RegisterSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String avatar;
  RegisterSubmittedEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avatar,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  ForgotPasswordEvent(this.email);
}