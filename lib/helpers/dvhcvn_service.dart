import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

class DvhcvnService {
  static String getAddressFromId(String id1, String id2, String id3) {
    final tinh = dvhcvn.findLevel1ById(id1);
    final huyen = tinh?.findLevel2ById(id2);
    final xa = huyen?.findLevel3ById(id3);
    return "${tinh!.name} ${huyen!.name}";
  }
}
