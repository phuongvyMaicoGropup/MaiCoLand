import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:maico_land/model/formz_model/models.dart';
import 'package:maico_land/model/formz_model/phone.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepo;
  RegisterBloc({required UserRepository userRepo})
      : _userRepo = userRepo,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterSubmitted>(_onSubmitted);
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterPhoneChanged>(_onPhoneChanged);
  }
  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email.toString());
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.firstName,
        state.lastName,
        state.username
      ]),
    ));
  }

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username.toString());
    print("username: " + username.toString());
    emit(state.copyWith(
      username: username,
      status: Formz.validate([
        username,
        state.firstName,
        state.lastName,
        state.email,
        state.password,
      ]),
    ));
  }

  void _onLastNameChanged(
    RegisterLastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final lastName = LastName.dirty(event.lastName.toString());
    print("lasname: " + lastName.toString());
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        lastName,
        state.password,
        state.email,
        state.firstName,
        state.username
      ]),
    ));
  }

  void _onFirstNameChanged(
    RegisterFirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final firstName = FirstName.dirty(event.firstName.toString());
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.password,
        state.email,
        state.lastName,
        state.username,
        state.phone
      ]),
    ));
  }

  void _onPhoneChanged(
    RegisterPhoneChanged event,
    Emitter<RegisterState> emit,
  ) {
    final phone = Phone.dirty(event.phone.toString());
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([
        phone,
        state.firstName,
        state.password,
        state.email,
        state.lastName,
        state.username,
      ]),
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password.toString());
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
        state.username,
        state.lastName,
        state.firstName,
        state.phone,
      ]),
    ));
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        // String result = "true";
        bool result = await _userRepo.register(
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          email: state.email.value,
          password: state.password.value,
          username: state.username.value,
          phoneNumber: state.phone.value,
        );
        if (result == true) {
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
