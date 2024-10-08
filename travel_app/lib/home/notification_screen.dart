import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // Increased AppBar height
        child: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white), // Đặt màu nút mũi tên quay lại
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/halong.png'), // Path to image
                fit: BoxFit.cover, // Cover the entire area
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft, // Align text to bottom left
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Padding for text
                child: Text(
                  'Notifications', // Fixed typo here
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 24, // Text size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notification items
          _buildNotification(
            imagePath: 'lib/images/person.png',
            message:
                'Tuan Tran accepted your request for the trip in Danang, Vietnam on Jan 20, 2020',
            date: 'Jan 16',
          ),
          SizedBox(height: 10),
          _buildNotification(
            imagePath: 'lib/images/message.png',
            message:
                'Emmy sent you an offer for the trip in Ho Chi Minh, Vietnam on Feb 12, 2020',
            date: 'Jan 16',
          ),
          SizedBox(height: 10),
          _buildNotification(
            imagePath: 'lib/images/check_circle.png',
            message:
                'Thanks! Your trip in Danang, Vietnam on Jan 20, 2020 has been finished. Please leave a review for the guide Tuan Tran.',
            date: 'Jan 24',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Action when pressed
              print('Leave Review pressed');
            },
            child: Text('Leave Review'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a notification item
  Widget _buildNotification({
    required String imagePath,
    required String message,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
