import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:land_app/logic/blocs/login_bloc/model/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc() :
  super(const LoginState()){
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  void _onEmailChanged(LoginEmailChanged event,
      Emitter<LoginState> emit,){
    final email = Email.dirty(event.email.toString());
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));

  }
  void _onPasswordChanged(
      LoginPasswordChanged event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password.toString());
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }
  void _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // await _authenticationRepository.logIn(
        //   email: state.email.value,
        //   password: state.password.value,
        // );
        // emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}