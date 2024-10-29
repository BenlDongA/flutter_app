import 'dart:convert';
import 'package:http/http.dart' as http;

// Model for travel location
class TravelLocation {
  final String avatar; // Image URL
  final String name; // Location name
  final String date; // Date string
  final int duration; // Duration in days
  final double price; // Price
  final int solike; // Number of likes

  TravelLocation({
    required this.avatar,
    required this.name,
    required this.date,
    required this.duration,
    required this.price,
    required this.solike,
  });

  factory TravelLocation.fromJson(Map<String, dynamic> json) {
    return TravelLocation(
      avatar: json['avatar'],
      name: json['name'],
      date: json['date'],
      duration: json['duration'], // Assume duration is in days
      price: json['price'].toDouble(), // Ensure price is a double
      solike: json['solike'], // Added solike
    );
  }
}

// Fetch travel locations from the API
Future<List<TravelLocation>> fetchTravelLocations() async {
  final response = await http.get(
    Uri.parse('https://api-flutter-2psk.onrender.com/api/trip'),
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((location) => TravelLocation.fromJson(location))
        .toList();
  } else {
    throw Exception('Failed to load travel locations');
  }
}
