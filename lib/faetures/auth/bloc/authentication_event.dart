part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class SignUpuser extends AuthenticationEvent {
  final String email;
  final String password;

  const SignUpuser({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class RegisterUser extends AuthenticationEvent {
  final BuildContext context;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterUser({required this.context, required this.name, required this.email, required this.password, required this.confirmPassword});
}

final class SignOut extends AuthenticationEvent {}
