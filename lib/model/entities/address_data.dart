import 'package:dvhcvn/dvhcvn.dart';
import 'package:flutter/material.dart';

class AddressData extends ChangeNotifier {
  int _latestChange = 1;
  int get latestChange => _latestChange;

  late Level1 _level1;
  Level1 get level1 => _level1;
  set level1(Level1 v) {
    if (v == _level1) return;

    _level1 = v;
    // _level2 = null;
    // _level3 = ;
    _latestChange = 1;
    notifyListeners();
  }

  late Level2 _level2;
  Level2 get level2 => _level2;
  set level2(Level2 v) {
    if (v == _level2) return;

    _level2 = v;
    // _level3 = null;
    _latestChange = 2;
    notifyListeners();
  }

  late Level3 _level3;
  Level3 get level3 => _level3;
  set level3(Level3 v) {
    if (v == _level3) return;

    _level3 = v;
    _latestChange = 3;
    notifyListeners();
  }

  // static AddressData of(BuildContext context, {bool listen = true}) =>
  //     Provider.of<AddressData>(context, listen: listen);
}