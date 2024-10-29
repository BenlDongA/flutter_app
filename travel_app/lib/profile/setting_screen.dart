import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled =
      true; // Biến để lưu trạng thái của nút chuyển đổi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60, // Đặt chiều cao của AppBar
        leading: IconButton(
          icon: Icon(Icons.close), // Biểu tượng "X"
          onPressed: () {
            Navigator.of(context).pop(); // Đóng trang hiện tại
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'SF Pro Display', // Font yêu cầu
            fontWeight: FontWeight.w600, // Định dạng chữ
            fontSize: 17, // Kích thước chữ
            height: 1.29, // Chiều cao dòng (line height)
          ),
        ),
        centerTitle: true, // Căn giữa tiêu đề
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              color:
                  Color.fromRGBO(0, 206, 166, 1.0), // Màu nền giống trong hình
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30, // Kích thước avatar
                    backgroundImage:
                        AssetImage('lib/images/avatar.jpeg'), // Đường dẫn ảnh
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuong Benl',
                          style: TextStyle(
                            color: Colors.white, // Màu chữ trắng
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Traveler',
                          style: TextStyle(
                            color: Colors.white70, // Màu chữ phụ
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToEditProfile(
                          context); // Gọi hàm điều hướng khi nhấn nút "EDIT PROFILE"
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Màu chữ
                      backgroundColor:
                          Color.fromRGBO(0, 206, 166, 1.0), // Nền xanh lá
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.white), // Viền trắng
                      ),
                    ),
                    child: Text('EDIT PROFILE'),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1, // Độ dày của đường phân cách
              height: 1, // Giảm chiều cao để không tạo khoảng trống lớn
              color: const Color.fromARGB(255, 219, 218, 218),
            ), // Divider dưới mục đầu tiên

            // Mục Notifications với Switch
            ListTile(
              leading: Container(
                padding:
                    EdgeInsets.all(8), // Padding để tạo khoảng cách cho viền
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // Viền đen
                ),
                child: Icon(Icons.notifications_none,
                    color:
                        const Color.fromARGB(255, 52, 51, 51)), // Icon màu đen
              ),
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontFamily: 'SF Pro Display', // Font yêu cầu
                  fontWeight: FontWeight.w400, // Độ dày chữ 400
                  fontSize: 16, // Kích thước chữ
                  color: const Color.fromARGB(255, 52, 51, 51), // Màu chữ đen
                ),
              ),
              trailing: Switch(
                value: _notificationsEnabled, // Giá trị của Switch
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value; // Cập nhật trạng thái
                  });
                },
                activeColor: Color.fromRGBO(
                    0, 206, 166, 1.0), // Màu khi Switch đang ở trạng thái "on"
              ),
              onTap: () {
                // Xử lý sự kiện nhấn vào mục Notifications nếu cần
              },
            ),

            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.language,
              title: 'Languages',
              onTap: () {
                // Xử lý sự kiện nhấn "Languages"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.payment,
              title: 'Payment',
              onTap: () {
                // Xử lý sự kiện nhấn "Payment"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.lock,
              title: 'Privacy & Policies',
              onTap: () {
                // Xử lý sự kiện nhấn "Privacy & Policies"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.feedback,
              title: 'Feedback',
              onTap: () {
                // Xử lý sự kiện nhấn "Feedback"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.list,
              title: 'Usage',
              onTap: () {
                // Xử lý sự kiện nhấn "Usage"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ),
            _buildListTile(
              icon: Icons.exit_to_app,
              title: 'Sign out',
              onTap: () {
                // Xử lý sự kiện nhấn "Sign out"
              },
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: const Color.fromARGB(255, 200, 200, 200),
            ), // Divider cuối cùng
          ],
        ),
      ),
    );
  }

  // Hàm điều hướng đến trang EditProfilePage
  void _navigateToEditProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              EditProfilePage()), // Điều hướng đến EditProfilePage
    );
  }

  // Hàm tái sử dụng để tạo ListTile
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8), // Padding để tạo khoảng cách cho viền
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Viền đen
        ),
        child: Icon(icon,
            color: const Color.fromARGB(255, 52, 51, 51)), // Icon màu đen
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'SF Pro Display', // Font yêu cầu
          fontWeight: FontWeight.w400, // Độ dày chữ 400
          fontSize: 16, // Kích thước chữ
          color: const Color.fromARGB(255, 52, 51, 51), // Màu chữ đen
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: const Color.fromARGB(255, 200, 200, 200), // Icon ">" màu nhạt
      ), // Icon ">" bên phải
      onTap: onTap, // Thêm sự kiện khi nhấn vào ListTile
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle saving profile changes
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.teal),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('lib/images/avatar.jpeg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Handle changing profile picture
                        },
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            TextFormField(
              initialValue: 'Cuong',
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              initialValue: 'Benl',
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              obscureText: true,
              initialValue: '........', // Giá trị mặc định
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Handle changing password
              },
              child: const Text(
                'Change Password',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
