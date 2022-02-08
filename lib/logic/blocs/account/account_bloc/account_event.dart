part of 'account_bloc.dart';

class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountLoad extends AccountEvent {}

class AccountRefresh extends AccountEvent {}
