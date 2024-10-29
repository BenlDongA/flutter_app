import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'setting_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ẩn status bar và navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false, // Xóa nút Back
          backgroundColor:
              const Color.fromARGB(0, 190, 4, 4), // Làm trong suốt AppBar
          elevation: 0, // Bỏ bóng dưới AppBar
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Xử lý khi người dùng nhấn vào biểu tượng cài đặt
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header Profile
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'lib/images/bg_profile.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Mờ nền bằng một Container có màu đen trong suốt
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black
                            .withOpacity(0.7), // Điều chỉnh độ mờ tại đây
                      ),
                    ),
                    // Nội dung trên ảnh
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('lib/images/avatar.jpeg'),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cuong Benl',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'cuongpy@gmail.com',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // My Photos Section
              SectionTitle(title: 'My Photos'),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    PhotoCard(
                      imageUrl: 'lib/images/pr1.jpeg',
                    ),
                    PhotoCard(
                      imageUrl: 'lib/images/pr2.jpg',
                    ),
                    PhotoCard(
                      imageUrl: 'lib/images/pr3.jpg',
                    ),
                    PhotoCard(
                      imageUrl: 'lib/images/pr4.png',
                    ),
                  ],
                ),
              ),

              // Thêm danh sách ảnh mới với kích thước khác

              Container(
                height: 100, // Kích thước chiều cao mới
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SmallPhotoCard(
                      imageUrl: 'lib/images/pr5.jpeg',
                    ),
                    SmallPhotoCard(
                      imageUrl: 'lib/images/pr6.jpg',
                    ),
                    SmallPhotoCard(
                      imageUrl: 'lib/images/pr7.jpeg',
                    ),
                    SmallPhotoCard(
                      imageUrl: 'lib/images/pr8.jpeg',
                    ),
                  ],
                ),
              ),

              // My Journeys Section
              SectionTitle(title: 'My Journeys'),
              JourneyCard(
                title: 'A memory in Danang',
                location: 'Danang, Vietnam',
                date: 'Jan 20, 2020',
                likes: 234,
                imageUrl: 'lib/images/pr9.jpg',
              ),
              JourneyCard(
                title: 'Sapa in spring',
                location: 'Sapa, Vietnam',
                date: 'Jan 20, 2020',
                likes: 234,
                imageUrl: 'lib/images/pr10.jpg',
              ),

              // Spacer
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class PhotoCard extends StatelessWidget {
  final String imageUrl;
  const PhotoCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Tạo một lớp mới cho các ảnh nhỏ
class SmallPhotoCard extends StatelessWidget {
  final String imageUrl;
  const SmallPhotoCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 150, // Kích thước nhỏ hơn
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class JourneyCard extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final int likes;
  final String imageUrl;

  const JourneyCard({
    required this.title,
    required this.location,
    required this.date,
    required this.likes,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl, fit: BoxFit.cover), // Sử dụng Image.asset
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(location),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(date),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$likes Likes'),
                Icon(Icons.favorite_border),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
