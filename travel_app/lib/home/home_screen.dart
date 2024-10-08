import 'package:flutter/material.dart';
import 'notification_screen.dart';

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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bg_welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SingleChildScrollView(
            // Thêm SingleChildScrollView ở đây
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
                  SizedBox(height: 40),
                  Container(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildDreamTripCard('Amalfi', 'Italy',
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/11/0d79ij9ruoja1698812184967.jpg'),
                        _buildDreamTripCard('Santorini', 'Greece',
                            'https://ik.imagekit.io/tvlk/blog/2024/07/canh-dep-viet-nam-7.jpg?tr=dpr-2,w-675'),
                        _buildDreamTripCard('Bali', 'Indonesia',
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/11/0d79ij9ruoja1698812184967.jpg'),
                        _buildDreamTripCard('Kyoto', 'Japan',
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/11/0d79ij9ruoja1698812184967.jpg'),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildPopularTripCard('CaoBang', 'VietNam',
                            'https://ik.imagekit.io/tvlk/blog/2024/07/canh-dep-viet-nam-7.jpg?tr=dpr-2,w-675'),
                        _buildPopularTripCard('HoiAn', 'VietNam',
                            'https://m.yodycdn.com/blog/phong-canh-dep-o-viet-nam-yody-vn-14.jpg'),
                        _buildPopularTripCard('London', 'UK',
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/11/0d79ij9ruoja1698812184967.jpg'),
                        _buildPopularTripCard('Sydney', 'Australia',
                            'https://vnpay.vn/s1/statics.vnpay.vn/2023/11/0d79ij9ruoja1698812184967.jpg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    // Chuyển đến màn hình thông báo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsScreen()),
                    );
                  },
                ),
                // Số thông báo
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
                        '3', // Số thông báo
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
          image: NetworkImage(imagePath),
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
          image: NetworkImage(imagePath),
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
