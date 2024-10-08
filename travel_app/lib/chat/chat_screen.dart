import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String name; // Thêm tên người dùng để hiển thị trong chat
  final String avatar; // Thêm avatar cho người dùng

  const ChatScreen({Key? key, required this.name, required this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close), // Biểu tượng dấu X
          onPressed: () {
            Navigator.pop(context); // Quay lại khi nhấn vào nút close
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(avatar), // Hiển thị avatar
              radius: 18,
            ),
            const SizedBox(width: 8), // Khoảng cách giữa tên và icon cộng
            Container(
              padding:
                  const EdgeInsets.all(6), // Khoảng cách bên trong container
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 236, 233, 233), // Màu nền của hình tròn
                shape: BoxShape.circle, // Hình dạng tròn
              ),
              child: Icon(
                Icons.add, // Biểu tượng dấu cộng
                color: const Color.fromARGB(255, 0, 249, 54), // Màu biểu tượng
                size: 24, // Kích thước biểu tượng
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                Center(
                  // Căn giữa đoạn văn bản
                  child: Text(
                    "Jan 28, 2020",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(height: 10),
                // Tin nhắn từ Emmy
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(avatar), // Hiển thị avatar
                      radius: 18,
                    ),
                    const SizedBox(
                        width: 5), // Giảm khoảng cách giữa avatar và tên
                    Text(
                      name, // Hiển thị tên người dùng trên AppBar
                    ),
                    // Không cần thêm IconButton ở đây nữa
                  ],
                ),
                ChatBubble(
                  message: "hi, this is $name",
                  time: "10:30 AM",
                  isSender: false,
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                ),

                ChatBubble(
                  message:
                      "It is a long established fact that a reader will be distracted by the",
                  time: "10:30 AM",
                  isSender: false,
                  isLongMessage: true,
                  textColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                const SizedBox(height: 10),
                // Tin nhắn từ người dùng
                ChatBubble(
                  message: "as opposed to using 'Content here'",
                  time: "10:31 AM",
                  isSender: true,
                  textColor: Colors.black,
                ),
                ChatBubble(
                  message: "There are many variations of passages",
                  time: "10:31 AM",
                  isSender: true,
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
          // Thanh nhập tin nhắn
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Biểu tượng hình ảnh
                IconButton(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // Hành động khi nhấn vào biểu tượng hình ảnh
                  },
                ),
                // Biểu tượng microphone
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Hành động khi nhấn vào biểu tượng microphone
                  },
                ),
                // Ô nhập liệu
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                // Nút gửi tin nhắn
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Hành động khi gửi tin nhắn
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;
  final bool isLongMessage;
  final Color textColor;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isSender,
    this.isLongMessage = false,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: isSender
                ? const Color.fromARGB(255, 139, 165, 172)
                : const Color.fromARGB(255, 0, 206, 166),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontSize: isLongMessage ? 16 : 14,
                  color: textColor, // Thiết lập màu chữ cho tin nhắn
                ),
              ),
              const SizedBox(height: 5),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
