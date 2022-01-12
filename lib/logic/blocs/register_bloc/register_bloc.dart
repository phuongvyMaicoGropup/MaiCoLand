import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:land_app/logic/blocs/Register_bloc/model/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{
  RegisterBloc() :
  super(const RegisterState()){
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }
  void _onEmailChanged(RegisterEmailChanged event,
      Emitter<RegisterState> emit,){
    final email = Email.dirty(event.email.toString());
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email, state.username]),
    ));

  }
  void _onUsernameChanged(RegisterUsernameChanged event,
      Emitter<RegisterState> emit,){
    final username = Username.dirty(event.username.toString());
    emit(state.copyWith(
      username: username,
      status: Formz.validate([state.password, username, state.email]),
    ));

  }
  void _onPasswordChanged(
      RegisterPasswordChanged event,
      Emitter<RegisterState> emit,
      ) {
    final password = Password.dirty(event.password.toString());
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email,state.username]),
    ));
  }
  void _onSubmitted(
      RegisterSubmitted event,
      Emitter<RegisterState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // await _authenticationRepository.Register(
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