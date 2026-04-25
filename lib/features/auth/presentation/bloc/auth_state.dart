abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}

class PasswordVisibilityState extends AuthState {
  final bool isObscure;
  PasswordVisibilityState(this.isObscure);
}