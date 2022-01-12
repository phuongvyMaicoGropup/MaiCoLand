import 'package:bloc/bloc.dart';
import 'package:land_app/model/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc( {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial()){
          on<AppLoaded>(_mapAppLoadedToState);
          on<UserLoggedIn>(_mapUserLoggedInToState);
          on<UserLoggedOut>(_mapUserLoggedOutToState);
        }


  void _mapAppLoadedToState(AppLoaded event, Emitter<AuthenticationState> emit,) async {
    
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final currentUser = await _authenticationRepository.user;
      print("apploaded " + currentUser);
      if (currentUser != null) {
        emit(AuthenticationAuthenticated(user: currentUser));
      } else {
        emit(AuthenticationNotAuthenticated());
      }
    } catch (e) {
      // emit(AuthenticationFailure(message: e.toString() ?? 'An unknown error occurred'));
    }
  }

  void _mapUserLoggedInToState(UserLoggedIn event, Emitter<AuthenticationState> emit,)  {
    emit(AuthenticationAuthenticated(user: event.user));
  } 

  void _mapUserLoggedOutToState(UserLoggedOut event , Emitter<AuthenticationState> emit,) async {
    await _authenticationRepository.signOut();
    emit(AuthenticationNotAuthenticated());
  }
}
