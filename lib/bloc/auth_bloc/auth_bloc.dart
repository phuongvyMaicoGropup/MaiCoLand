import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/entities/user.dart';
import 'package:maico_land/model/repositories/user_repository.dart';
import 'package:maico_land/model/responses/user_reponse.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepo;
  AuthenticationBloc({required this.userRepo})
      : assert(userRepo != null),
        super(AuthenticationUninitialized()) {
    on<AppStarted>(_mapAppStartedToState);
    on<LoggedIn>(_mapLoggedInToState);
    on<LoggedOut>(_mapLoggedOutToState);
  }

  void _mapAppStartedToState(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    final String token = await userRepo.hasToken();

    if (token != "") {
      User userResponse = userRepo.getUserInfo(token);
      emit(AuthenticationAuthenticated(userResponse));
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }

  Future<void> _mapLoggedInToState(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    User userResponse = userRepo.getUserInfo(event.token);
    print("login success");

    await userRepo.persisteToken(event.token);
    emit(AuthenticationAuthenticated(userResponse));
  }

  void _mapLoggedOutToState(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    await userRepo.deleteToken();
    emit(AuthenticationUnauthenticated());
  }
}
