import 'dart:convert';

class GeoPoint {
  GeoPoint(
    this.longitude,
    this.latitude,
  );
  final double longitude;
  final double latitude;

  GeoPoint copyWith({
    double? longitude,
    double? latitude,
  }) {
    return GeoPoint(
      longitude ?? this.longitude,
      latitude ?? this.latitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory GeoPoint.fromMap(Map<String, dynamic> map) {
    return GeoPoint(
      map['longitude']?.toDouble() ?? 0.0,
      map['latitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoPoint.fromJson(String source) => GeoPoint.fromMap(json.decode(source));

  @override
  String toString() => 'GeoPoint(longitude: $longitude, latitude: $latitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GeoPoint &&
      other.longitude == longitude &&
      other.latitude == latitude;
  }

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;
}
