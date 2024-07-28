part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {
  final bool isLoading;

  const AuthenticationLoadingState({required this.isLoading});
}

final class AuthenticationSuccess extends AuthenticationState {}

final class AuthenticationFailure extends AuthenticationState {
  final String errorMsg;

  const AuthenticationFailure({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

final class RegistrationUserSuccess extends AuthenticationState {}

final class RegistrationUserFailure extends AuthenticationState {
  final String error;

  const RegistrationUserFailure({required this.error});
}

final class RegistrationUserLoading extends AuthenticationState {}
