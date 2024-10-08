import 'package:flutter/material.dart';
import 'data_travel_card.dart'; // Import the data class with the API fetching logic
import 'travel_card.dart'; // Import the TravelCard class

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String searchQuery = "";
  late Future<List<TravelLocation>> futureLocations;

  @override
  void initState() {
    super.initState();
    futureLocations = fetchTravelLocations(); // Fetch travel locations once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://cdn.pixabay.com/photo/2015/10/30/20/13/boat-1014711_640.jpg',
                fit: BoxFit.cover,
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Plenty of amazing tours are waiting for you",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    _buildSearchField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildGuidesSection(),
            Container(
              alignment: Alignment.centerLeft, // Căn chỉnh sang bên trái
              padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 16.0,
                  bottom: 8.0), // Thêm padding để tạo khoảng cách
              child: Text(
                "Featured Tours",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: TravelList(
                searchQuery: searchQuery,
                futureLocations: futureLocations,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Guides in Danang",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          // Sử dụng GridView để hiển thị thẻ
          GridView.count(
            crossAxisCount: 2, // Số cột là 2
            childAspectRatio: 0.9, // Tỷ lệ chiều cao và chiều rộng của thẻ
            physics:
                NeverScrollableScrollPhysics(), // Ngăn cuộn để có thể cuộn bên ngoài
            shrinkWrap: true, // Để GridView sử dụng không gian nhỏ hơn
            padding: EdgeInsets.symmetric(
                vertical: 8.0), // Khoảng cách dọc giữa các thẻ
            mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
            crossAxisSpacing: 2.0, // Khoảng cách giữa các cột
            children: [
              guideCard("Tuan Tran", "Danang, Vietnam", 127,
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-NGEQDekk2BwsllLjk4tcIM_BPIzXECdsg&s"),
              guideCard("Emmy", "Hanoi, Vietnam", 98,
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-NGEQDekk2BwsllLjk4tcIM_BPIzXECdsg&s"),
              guideCard("Linh Hana", "Danang, Vietnam", 127,
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-NGEQDekk2BwsllLjk4tcIM_BPIzXECdsg&sg"),
              guideCard("Khai Ho", "Ho Chi Minh, Vietnam", 127,
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-NGEQDekk2BwsllLjk4tcIM_BPIzXECdsg&s"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      alignment: Alignment.center,
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value; // Update search query
          });
        },
        decoration: InputDecoration(
          hintText: 'Hi, where do you want to explore?',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget guideCard(String name, String location, int reviews, String imageUrl) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.49, // 48% width
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust margin
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 5, // Position the reviews text
                  left: 10,
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "$reviews Reviews",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(location, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
