// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:land_app/model/api/user/Account_user.dart';
// import 'package:land_app/model/repository/authentication_repository.dart';
// import 'package:maico_land/model/repositories/user_repository.dart';
// part 'account_event.dart';
// part 'account_state.dart';

// class AccountBloc extends Bloc<AccountEvent, AccountState> {
//   final UserRepository userRepo;

//   AccountBloc({required this.userRepo}) : super(AccountLoading()){
//     on<AccountLoad>(_mapAccountLoadToState);
//     on<AccountRefresh>((event,emit){
//         emit(AccountLoading());
//     });
//   }


//   void _mapAccountLoadToState(AccountLoad event, Emitter<AccountState> emit,) async {
//     try {

//       // User user = authenticationRepo.user;
// // 
//       emit(AccountLoaded(user: user));
//     } catch (e) {
//       emit(AccountNotLoaded("Lỗi nè " + e.toString()));
//     }
//   }
  
// }
