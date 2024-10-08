import 'package:flutter/material.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background image with reduced height
          Stack(
            children: [
              Image.network(
                'https://cdn3.ivivu.com/2022/08/c%E1%BA%A7u-R%E1%BB%93ng-%C4%90%C3%A0-N%E1%BA%B5ng-ivivu.jpg',
                height: 150, // Reduced height
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 30,
                left: 16,
                child: Text(
                  'My Trips',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // TabBar below the image
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            indicator: BoxDecoration(
              color: const Color.fromARGB(255, 0, 206, 166),
              borderRadius: BorderRadius.circular(4),
            ),
            tabs: [
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Now Trips',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Next Trips',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Past Trips',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  'Wish List',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
          ),

          // TabBar content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNowTrips(),
                _buildNextTrips(),
                _buildPastTrips(),
                WishList(), // Wish List widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Hàm này dùng để tái sử dụng cho từng thẻ
Widget _buildNowTrips() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildNowTripCard(
            largeImageUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTuQXpRQ3NP-MM3iBgnlHvGT69NfZkVISu3A&s',
            avatarUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTuQXpRQ3NP-MM3iBgnlHvGT69NfZkVISu3A&s', // Replace with your avatar URL
            title: 'Dragon Bridge Trip',
            location: 'Da Nang, Vietnam',
            date: 'Jan 30, 2020',
            time: '13:00 - 15:00',
            person: 'Benl',
          ),
        ],
      ),
    ),
  );
}

Widget _buildNextTrips() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildNextTripCard(
            largeImageUrl:
                'https://vcdn1-dulich.vnecdn.net/2022/06/01/Hoi-An-VnExpress-5851-16488048-4863-2250-1654057244.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=Z2ea_f0O7kgGZllKmJF92g', // Replace with your image URL
            avatarUrl:
                'https://thumbs.dreamstime.com/b/generative-ai-young-smiling-man-avatar-man-brown-beard-mustache-hair-wearing-yellow-sweater-sweatshirt-d-vector-people-279560903.jpg', // Replace with your avatar URL
            title: 'Hoi An Trip',
            location: 'Hoi An, Vietnam',
            date: 'Feb 15, 2024',
            time: '09:00 - 17:00',
            person: 'Alice',
          ),
          _buildNextTripCard(
            largeImageUrl:
                'https://ik.imagekit.io/tvlk/blog/2023/01/canh-dep-da-lat-1.jpg?tr=dpr-2,w-675', // Replace with your image URL
            avatarUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-QSTiahdKODtBSzMaIxXzFqzQCzLpBPqevQ&s', // Replace with your avatar URL
            title: 'Da La',
            location: 'Dat Lat, Vietnam',
            date: 'Feb 15, 2024',
            time: '09:00 - 17:00',
            person: 'Alice',
          ),
          _buildNextTripCard(
            largeImageUrl:
                'https://vcdn1-dulich.vnecdn.net/2022/05/22/3-Ganh-Da-Dia-Xa-An-Ninh-Dong-6856-2221-1653188298.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=SEFRlIA7eVwOR-bXNY0Inw', // Replace with your image URL
            avatarUrl:
                'https://vcdn1-dulich.vnecdn.net/2022/05/22/3-Ganh-Da-Dia-Xa-An-Ninh-Dong-6856-2221-1653188298.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=SEFRlIA7eVwOR-bXNY0Inw', // Replace with your avatar URL
            title: 'Phu Yen',
            location: 'Phu Yen, Vietnam',
            date: 'Feb 15, 2024',
            time: '09:00 - 17:00',
            person: 'Alice',
          ),
        ],
      ),
    ),
  );
}

Widget _buildNowTripCard({
  required String largeImageUrl,
  required String avatarUrl,
  required String title,
  required String location,
  required String date,
  required String time,
  required String person,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                largeImageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Xử lý khi nhấn nút "Mark Finished"
                },
                icon: Icon(Icons.check),
                label: Text('Mark Finished'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white.withOpacity(0.6), // Độ trong suốt
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 49, 49, 49), // Màu viền
                      width: 1, // Độ dày viền
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 206, 166), // Màu viền
                        width: 2, // Độ dày của viền
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                      radius: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(location),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(date),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(time),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(person),
                ],
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  // Navigate to detail page
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: Color.fromARGB(255, 0, 206, 166),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info, color: Color.fromARGB(255, 0, 206, 166)),
                    SizedBox(width: 8),
                    Text(
                      'Detail',
                      style: TextStyle(color: Color.fromARGB(255, 0, 206, 166)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildNextTripCard({
  required String largeImageUrl,
  required String avatarUrl,
  required String title,
  required String location,
  required String date,
  required String time,
  required String person,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            largeImageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 206, 166), // Màu viền
                        width: 2, // Độ dày của viền
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                      radius: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(location),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(date),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(time),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(person),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Canh giữa hàng
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Navigate to detail page
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10), // Điều chỉnh padding tại đây
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 206, 166),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info,
                            color: Color.fromARGB(255, 0, 206, 166)),
                        SizedBox(width: 5),
                        Text(
                          'Detail',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 206, 166)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Khoảng cách giữa các nút
                  OutlinedButton(
                    onPressed: () {
                      // Hành động cho nút thứ hai
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 13), // Điều chỉnh padding tại đây
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 206, 166),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.message,
                            color: Color.fromARGB(255, 0, 206, 166)),
                        SizedBox(width: 5),
                        Text(
                          'Chat',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 206, 166)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20), // Khoảng cách giữa các nút
                  OutlinedButton(
                    onPressed: () {
                      // Hành động cho nút thứ ba
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 13), // Điều chỉnh padding tại đây
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Color.fromARGB(255, 0, 206, 166),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flag,
                            color: Color.fromARGB(255, 0, 206, 166)),
                        SizedBox(width: 5),
                        Text(
                          'Start',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 206, 166)),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPastTrips() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildPastTripCard(
            largeImageUrl:
                'https://hoanghamobile.com/tin-tuc/wp-content/uploads/2024/04/anh-ha-noi.jpg', // Replace with your image URL
            avatarUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUBGkU6RlPys2OU0fMS5jsRU-QfbOEf6X5NA&s', // Replace with your avatar URL
            title: 'Ho Guom, Ha Noi',
            location: 'Ha Noi, Viet Nam',
            date: 'Dec 20, 2022',
            time: '08:00 - 16:00',
            person: 'Charlie',
          ),
          _buildPastTripCard(
            largeImageUrl:
                'https://localvietnam.com/wp-content/uploads/2021/04/hue-imperial-gate-1024x683.jpg', // Replace with your image URL
            avatarUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmynqWDb2Mt3TjOf86va5lIwcf-85bLNIqAA&s', // Replace with your avatar URL
            title: 'Kinh Thanh Hue',
            location: 'Hue, viet Nam',
            date: 'Dec 20, 2022',
            time: '08:00 - 16:00',
            person: 'Charlie',
          ),
        ],
      ),
    ),
  );
}

Widget _buildPastTripCard({
  required String largeImageUrl,
  required String avatarUrl,
  required String title,
  required String location,
  required String date,
  required String time,
  required String person,
}) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Image.network(
            largeImageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromARGB(255, 0, 206, 166), // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl),
                      radius: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(location),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(date),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(time),
                ],
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.grey, size: 16),
                  SizedBox(width: 4),
                  Text(person),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// The WishList class is now properly structured outside of the TripsScreen
class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  // Danh sách để lưu trữ thông tin của từng thẻ
  List<WishListItem> wishListItems = [
    WishListItem(
      largeImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXKFxkyQSyG91kKxlx2pFi4jjE5jdqpwO1fA&s',
      title: 'DaNang',
      date: 'Dec 20, 2022',
      likes: 120,
      price: 9.99,
      duration: 7,
    ),
    WishListItem(
      largeImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyeBCICt8CmzgsBsQHoTrr_BeMU0pPn5j_ow&s',
      title: 'HaiPhong',
      date: 'Dec 10, 2023',
      likes: 85,
      price: 15.00,
      duration: 5,
    ),
    WishListItem(
      largeImageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRiSsyWNrCEz-yz0M5wTM5t7YeCFK-DgpEJg&s',
      title: 'PhuYen',
      date: 'Jan 15, 2023',
      likes: 85,
      price: 15.00,
      duration: 5,
    ),
    // Thêm nhiều thẻ khác nếu cần
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children:
              wishListItems.map((item) => _buildWishListCard(item)).toList(),
        ),
      ),
    );
  }

  Widget _buildWishListCard(WishListItem item) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Container(
        width: 570, // Đặt chiều rộng của thẻ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    item.largeImageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        item.isBookmarked = !item.isBookmarked;
                      });
                    },
                    child: Icon(
                      item.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Text(item.likes.toString()),
                          SizedBox(width: 4),
                          Text("Likes"),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isLiked = !item.isLiked;
                          });
                        },
                        child: Icon(
                          item.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 5),
                      Text(item.date),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 5),
                      Text("${item.duration} days"),
                      Spacer(),
                      Text(
                        "\$${item.price}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Lớp để lưu trữ dữ liệu cho mỗi thẻ
class WishListItem {
  final String largeImageUrl;
  final String title;
  final String date;
  final int likes;
  final double price;
  final int duration;
  bool isLiked = false; // Trạng thái "thích"
  bool isBookmarked = false; // Trạng thái "đánh dấu"

  WishListItem({
    required this.largeImageUrl,
    required this.title,
    required this.date,
    required this.likes,
    required this.price,
    required this.duration,
  });
}
