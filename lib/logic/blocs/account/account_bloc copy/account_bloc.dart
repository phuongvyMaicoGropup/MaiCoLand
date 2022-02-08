// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:land_app/model/api/user/Account_user.dart';
// import 'package:land_app/model/repository/authentication_repository.dart';
// part 'account_event.dart';
// part 'account_state.dart';

// class AccountBloc extends Bloc<AccountEvent, AccountState> {
//   final AuthenticationRepository authenticationRepo;

//   AccountBloc({required this.authenticationRepo}) : super(AccountLoading()){
//      on<AccountUsernameChanged>(_onUsernameChanged);
//     on<AccountCanEditUserNameChanged>(_onCanEditUserNameChanged);
//     on<AccountPhoneNumberChanged>(_onPhoneNumberChanged);
//     on<AccountCanEditPhoneNumberChanged>(_onCanEditPhoneNumberChanged);
//     on<AccountSubmitted>(_onSubmitted);
    
//   }


//   void _mapAccountLoadToState(AccountLoad event, Emitter<AccountState> emit,) async {
//     try {

//       User user = authenticationRepo.user;

//       emit(AccountLoaded(user: user));
//     } catch (e) {
//       emit(AccountNotLoaded("Lỗi nè " + e.toString()));
//     }
//   }
  
// }
