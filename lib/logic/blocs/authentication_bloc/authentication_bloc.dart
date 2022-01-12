// import 'package:bloc/bloc.dart';
// import 'package:land_app/model/repository/authentication_repository.dart';

// import 'authentication_event.dart';
// import 'authentication_state.dart';

// class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
//   final AuthenticationRepository _authenticationRepository;

//   AuthenticationBloc(AuthenticationRepository authenticationRepository)
//       : assert(authenticationRepository != null),
//         _authenticationRepository = authenticationRepository,
//         super(AuthenticationInitial()){
//           on<AppLoaded>(_mapAppLoadedToState);

//         }


//   void _mapAppLoadedToState(AppLoaded event, Emitter<AuthenticationState> emit,) async {
//     emit( AuthenticationLoading());
//     try {
//       await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
//       final currentUser = await _authenticationRepository.user;

//       if (currentUser != null) {
//         emit(AuthenticationAuthenticated(user: currentUser));
//       } else {
//         emit(AuthenticationNotAuthenticated());
//       }
//     } catch (e) {
//       // emit(AuthenticationFailure(message: e.toString() ?? 'An unknown error occurred'));
//     }
//   }

//   void _mapUserLoggedInToState(UserLoggedIn event, Emitter<AuthenticationState> emit,)  {
//     emit(AuthenticationAuthenticated(user: event.user));
//   }

//   void _mapUserLoggedOutToState(UserLoggedOut event , Emitter<AuthenticationState> emit,) async {
//     await _authenticationRepository.signOut();
//     emit(AuthenticationNotAuthenticated());
//   }
// }
