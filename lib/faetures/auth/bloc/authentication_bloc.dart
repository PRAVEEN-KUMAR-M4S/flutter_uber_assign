
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_clone/faetures/auth/repository/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService;
  AuthenticationBloc(this.authService) : super(AuthenticationInitial()) {
    on<SignUpuser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        
            await authService.signUpUser(event.email, event.password);
        
          emit(AuthenticationSuccess());
        
          emit(const AuthenticationFailure(errorMsg: 'Error occured'));
        
         emit(const AuthenticationLoadingState(isLoading: false));
      } catch (e) {
        emit(AuthenticationFailure(errorMsg: e.toString()));
      }
     
    });

    on<RegisterUser>((event, emit) async {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        await authService.regUser(event.context, event.email, event.password,
            event.confirmPassword, event.name);
        emit(RegistrationUserSuccess());
         emit(const AuthenticationLoadingState(isLoading: false));
      } catch (e) {
        emit(RegistrationUserFailure(error: e.toString()));
      }
    });

    on<SignOut>((event, emit) {
      emit(const AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOutUser();
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
