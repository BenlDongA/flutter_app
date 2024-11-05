// trip_model.dart
class Trip {
  final String id;
  final String imageUrl;
  final String locationName;
  final String countryName;
  final String typeHome;

  Trip({
    required this.id,
    required this.imageUrl,
    required this.locationName,
    required this.countryName,
    required this.typeHome,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      locationName: json['locationName'],
      countryName: json['countryName'],
      typeHome: json[
          'tpye_home'], // Note: 'tpye_home' should be 'type_home' based on your example
    );
  }
}
