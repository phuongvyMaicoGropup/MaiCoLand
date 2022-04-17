import 'package:dvhcvn/dvhcvn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maico_land/bloc/address_bloc/address.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc()
      : super(AddressState(
            level1: const Level1("", "", Type.huyen, []),
            level2: const Level2(0, "", "", Type.phuong, []),
            level3: const Level3(
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
        level2: const Level2(0, "", "", Type.phuong, []),
        level3: const Level3(0, 0, "", "", Type.phuong)));
  }

  Future<void> _mapAddressInitialToState(
    AddressInitial event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(
        level1: const Level1("", "", Type.huyen, []),
        level2: const Level2(0, "", "", Type.phuong, []),
        level3: const Level3(
          0,
          0,
          "",
          "",
          Type.huyen,
        )));
  }

  Future<void> _mapAddressIdLevel2SelectedToState(
    AddressIdLevel2Selected event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(
        level2: event.item, level3: const Level3(0, 0, "", "", Type.phuong)));
  }

  Future<void> _mapAddressIdLevel3SelectedToState(
    AddressIdLevel3Selected event,
    Emitter<AddressState> emit,
  ) async {
    emit(state.copyWith(level3: event.item));
  }
}
