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
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
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
            SizedBox(height: 20), // Padding to avoid overflow
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
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 2.0,
            children: [
              guideCard("Tuan Tran", "Danang, Vietnam", 127,
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg/800px-Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg"),
              guideCard("Emmy", "Hanoi, Vietnam", 98,
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb-NGEQDekk2BwsllLjk4tcIM_BPIzXECdsg&s"),
              guideCard("Linh Hana", "Danang, Vietnam", 127,
                  "https://tmssl.akamaized.net//images/foto/galerie/ronaldo-cristiano-2017-real-madrid-ballon-d-or-2016-0026751808hjpg-1698686328-120749.jpg?lm=1698686338"),
              guideCard("Khai Ho", "Ho Chi Minh, Vietnam", 127,
                  "https://media.tinthethao.com.vn/files/bongda/2024/05/26/r1188646_1296x729_16-9jpg.jpg"),
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
      width: MediaQuery.of(context).size.width * 0.49,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
                  bottom: 5,
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
