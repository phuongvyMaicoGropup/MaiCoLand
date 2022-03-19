import 'dart:convert';

class Address {
  final String idLevel1;
  final String idLevel2;
  final String idLevel3;

  Address(
    this.idLevel1,
    this.idLevel2,
    this.idLevel3,
  );

  Address copyWith({
    String? idLevel1,
    String? idLevel2,
    String? idLevel3,
  }) {
    return Address(
      idLevel1 ?? this.idLevel1,
      idLevel2 ?? this.idLevel2,
      idLevel3 ?? this.idLevel3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idLevel1': idLevel1,
      'idLevel2': idLevel2,
      'idLevel3': idLevel3,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      map['idLevel1'] ?? '',
      map['idLevel2'] ?? '',
      map['idLevel3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(json.decode(source));

  @override
  String toString() => 'Address(idLevel1: $idLevel1, idLevel2: $idLevel2, idLevel3: $idLevel3)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Address &&
      other.idLevel1 == idLevel1 &&
      other.idLevel2 == idLevel2 &&
      other.idLevel3 == idLevel3;
  }

  @override
  int get hashCode => idLevel1.hashCode ^ idLevel2.hashCode ^ idLevel3.hashCode;
}
