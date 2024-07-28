import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:uber_clone/faetures/models/user_model.dart';

part 'appuser_state.dart';

class AppuserCubit extends Cubit<AppuserState> {
  AppuserCubit() : super(AppuserInitial());
    void updateUser(UserModel? user) {
    if (user == null) {
      emit(AppuserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
