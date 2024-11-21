import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'trip_model.dart'; // Import the model you created
import 'notification_screen.dart'; // Import your notification screen

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Trip> trips = [];

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  Future<void> fetchTrips() async {
    final response = await http.get(Uri.parse(
        'https://api-flutter-nper.onrender.com/api/home')); // Your API URL

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        trips = data.map((json) => Trip.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load trips');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bg_welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find Your\nDream Trip',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildSearchBar(),
                  SizedBox(height: 20),
                  Text(
                    'Dream Trips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 250,
                    child: trips.isNotEmpty
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildTripCards('DreamTrip'),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Popular Trips',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    child: trips.isNotEmpty
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: _buildTripCards('PopularTrip'),
                          )
                        : Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
          ),
          // Notification Button
          Positioned(
            top: 16,
            right: 16,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationsScreen(),
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTripCards(String typeHome) {
    return trips.where((trip) => trip.typeHome == typeHome).map((trip) {
      if (typeHome == 'DreamTrip') {
        return _buildDreamTripCard(
            trip.locationName, trip.countryName, trip.imageUrl);
      } else {
        return _buildPopularTripCard(
            trip.locationName, trip.countryName, trip.imageUrl);
      }
    }).toList();
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for destinations...',
          hintStyle: TextStyle(color: Colors.grey),
          icon: Icon(Icons.search, color: Colors.orange),
        ),
      ),
    );
  }

  Widget _buildDreamTripCard(
      String destination, String country, String imagePath) {
    return Container(
      width: 320,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: imagePath.contains('http')
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black.withOpacity(0.6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    country,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTripCard(
      String destination, String country, String imagePath) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: imagePath.contains('http')
              ? NetworkImage(imagePath)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              destination,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              country,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
