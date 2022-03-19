import 'dart:math';

import 'package:dvhcvn/dvhcvn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';
import 'package:maico_land/bloc/auth_bloc/auth.dart';
import 'package:maico_land/model/repositories/user_repository.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc()
      : super(AddressState(
            level1: Level1("", "", Type.huyen, []),
            level2: Level2(0, "", "", Type.phuong, []),
            level3: Level3(
              0,
              0,
              "",
              "",
              Type.huyen,
            ))) {
    on<AddressIdLevel1Selected>(_mapAddressIdLevel1SelectedToState);
    on<AddressIdLevel2Selected>(_mapAddressIdLevel2SelectedToState);
    on<AddressIdLevel3Selected>(_mapAddressIdLevel3SelectedToState);
    on<AddressInitial>(_mapAddressInitialToState);
  }

  Future<void> _mapAddressIdLevel1SelectedToState(
    AddressIdLevel1Selected event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(
        level1: event.item,
        level2: Level2(0, "", "", Type.phuong, []),
        level3: Level3(0, 0, "", "", Type.phuong)));
    print(state);
  }

  Future<void> _mapAddressInitialToState(
    AddressInitial event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(
        level1: Level1("", "", Type.huyen, []),
        level2: Level2(0, "", "", Type.phuong, []),
        level3: Level3(
          0,
          0,
          "",
          "",
          Type.huyen,
        )));
    print(state);
  }

  Future<void> _mapAddressIdLevel2SelectedToState(
    AddressIdLevel2Selected event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(
        level2: event.item, level3: Level3(0, 0, "", "", Type.phuong)));
  }

  Future<void> _mapAddressIdLevel3SelectedToState(
    AddressIdLevel3Selected event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(level3: event.item));
  }
}
