import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/bloc/login_bloc/login.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepo;
  final AuthenticationBloc authBloc;

  LoginBloc({required this.userRepo, required this.authBloc})
      : assert(userRepo != null),
        assert(authBloc != null),
        super(LoginInitial()) {
    on<LoginButtonPressed>(_mapLoginButtonPressedToState);
  }
  Future<void> _mapLoginButtonPressedToState(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final token = await userRepo.login(
          event.username, event.password, event.rememberMe);
      authBloc.add(LoggedIn(token: token));
      emit(LoginInitial());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
