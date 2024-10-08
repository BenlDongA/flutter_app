import 'package:flutter/material.dart';
import 'data_travel_card.dart'; // Import the data class with the API fetching logic

class TravelCard extends StatefulWidget {
  final TravelLocation location;

  TravelCard({required this.location});

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  bool isBookmarked = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
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
                  widget.location.avatar,
                  height: 200,
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
                      isBookmarked = !isBookmarked;
                    });
                  },
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
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
                        Text(widget.location.solike.toString()),
                        SizedBox(width: 4),
                        Text("Likes"), // Show likes
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.location.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 5),
                    Text(
                      formatDate(widget.location.date), // Format date
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 5),
                    Text(
                      "${widget.location.duration} days", // Show duration in days
                    ),
                    Spacer(),
                    Text(
                      "\$${widget.location.price}", // Show price
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
    );
  }

  String formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}"; // Format as day-month-year
  }
}

class TravelList extends StatefulWidget {
  final String searchQuery;
  final Future<List<TravelLocation>> futureLocations; // Add this line

  TravelList(
      {required this.searchQuery,
      required this.futureLocations}); // Update constructor

  @override
  _TravelListState createState() => _TravelListState();
}

class _TravelListState extends State<TravelList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TravelLocation>>(
      future: widget.futureLocations, // Use widget.futureLocations
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No locations found'));
        } else {
          final filteredLocations = snapshot.data!
              .where((location) => location.name
                  .toLowerCase()
                  .contains(widget.searchQuery.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredLocations.length,
            itemBuilder: (context, index) {
              return TravelCard(location: filteredLocations[index]);
            },
          );
        }
      },
    );
  }
}
