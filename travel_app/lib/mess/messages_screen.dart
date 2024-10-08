import 'package:flutter/material.dart';
import '../chat/chat_screen.dart'; // Nhập ChatScreen

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/halong.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Chat",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Chat',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: 'Tuan Tran', // Gửi tên tới ChatScreen
                          avatar:
                              'lib/images/person.png', // Gửi avatar tới ChatScreen
                        ),
                      ),
                    );
                  },
                  child: ChatItem(
                    avatar: 'lib/images/person.png',
                    name: 'Tuan Tran',
                    message: 'It\'s a beautiful place',
                    time: '10:30 AM',
                    unreadCount: 0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: 'Emmy', // Gửi tên tới ChatScreen
                          avatar:
                              'lib/images/message.png', // Gửi avatar tới ChatScreen
                        ),
                      ),
                    );
                  },
                  child: ChatItem(
                    avatar: 'lib/images/message.png',
                    name: 'Emmy',
                    message: 'We can start at 8am',
                    time: '',
                    unreadCount: 2,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          name: 'Khai Ho', // Gửi tên tới ChatScreen
                          avatar:
                              'lib/images/b2.png', // Gửi avatar tới ChatScreen
                        ),
                      ),
                    );
                  },
                  child: ChatItem(
                    avatar: 'lib/images/b2.png',
                    name: 'Khai Ho',
                    message: 'See you tomorrow',
                    time: '11:30 AM',
                    unreadCount: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  const ChatItem({
    Key? key,
    required this.avatar,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatar),
            radius: 25,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  message,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(time),
              if (unreadCount > 0)
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    unreadCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MessagesScreen(), // Đặt MessagesScreen là màn hình chính
  ));
}
