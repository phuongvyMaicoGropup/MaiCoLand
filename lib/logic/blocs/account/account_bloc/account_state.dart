part of 'account_bloc.dart';


abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final User user;

  const AccountLoaded( {required this.user});

  @override
  List<Object> get props {
    return [user];
  }

  @override
  String toString() {
    return 'LoadedAccount{user: $user}';
  }
}

class AccountNotLoaded extends AccountState {
  final String e;

  const AccountNotLoaded(this.e);

  @override
  String toString() {
    return 'AccountNotLoaded{e: $e}';
  }
}
