import 'package:flutter/material.dart';
import 'package:app_travel/Signin_Signup/sign_in_sign_up_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  final Map<String, dynamic> userData; // Thay đổi kiểu dữ liệu

  SettingsPage({required this.userData});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              color: Color.fromRGBO(0, 206, 166, 1.0),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('lib/images/avatar.jpeg'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userData['name'] ?? 'User Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Traveler',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _navigateToEditProfile(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromRGBO(0, 206, 166, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                    child: Text('EDIT PROFILE'),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Color.fromARGB(255, 219, 218, 218)),
            ListTile(
              leading: Icon(Icons.notifications_none,
                  color: Color.fromARGB(255, 52, 51, 51)),
              title: Text('Notifications'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: Color.fromRGBO(0, 206, 166, 1.0),
              ),
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.language,
              title: 'Languages',
              onTap: () {
                // Xử lý sự kiện nhấn "Languages"
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.payment,
              title: 'Payment',
              onTap: () {
                // Xử lý sự kiện nhấn "Payment"
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.lock,
              title: 'Privacy & Policies',
              onTap: () {
                // Xử lý sự kiện nhấn "Privacy & Policies"
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.feedback,
              title: 'Feedback',
              onTap: () {
                // Xử lý sự kiện nhấn "Feedback"
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.list,
              title: 'Usage',
              onTap: () {
                // Xử lý sự kiện nhấn "Usage"
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
            _buildListTile(
              icon: Icons.exit_to_app,
              title: 'Sign out',
              onTap: () {
                _signOut(context);
              },
            ),
            Divider(height: 1, color: Color.fromARGB(255, 200, 200, 200)),
          ],
        ),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) async {
    final updatedUserData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(userData: widget.userData),
      ),
    );

    // Nếu có dữ liệu mới, cập nhật userData
    if (updatedUserData != null) {
      setState(() {
        widget.userData['name'] = updatedUserData['name'];
        // Cập nhật thêm các trường khác nếu cần
      });
    }
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 52, 51, 51)),
      title: Text(title),
      trailing:
          Icon(Icons.chevron_right, color: Color.fromARGB(255, 200, 200, 200)),
      onTap: onTap,
    );
  }

  void _signOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInSignUpScreen()),
      (route) => false,
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData; // Thay đổi kiểu dữ liệu

  const EditProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userData['name'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text('SAVE', style: TextStyle(color: Colors.teal)),
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
                          // Xử lý thay đổi hình ảnh đại diện
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
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Current Password'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final newName = _nameController.text.trim();
    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    // Kiểm tra mật khẩu cũ
    if (oldPassword.isEmpty) {
      _showError('Please enter your current password.');
      return;
    }

    if (oldPassword != widget.userData['password']) {
      _showError('Current password is incorrect.');
      return;
    }

    // Gửi yêu cầu đến API để cập nhật thông tin
    try {
      final response = await http.put(
        Uri.parse(
            'https://api-flutter-nper.onrender.com/api/user/${widget.userData['_id']}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': widget.userData['email'],
          'name': newName,
          'password': newPassword.isNotEmpty ? newPassword : oldPassword,
        }),
      );

      if (response.statusCode == 200) {
        // Cập nhật thành công, lấy dữ liệu mới từ API
        final updatedUserData = json.decode(response.body);
        updatedUserData['password'] = newPassword.isNotEmpty
            ? newPassword
            : oldPassword; // Thêm mật khẩu mới
        Navigator.of(context).pop(updatedUserData); // Trả về dữ liệu mới
      } else {
        final errorMessage =
            json.decode(response.body)['message'] ?? 'Error updating profile';
        _showError(errorMessage);
      }
    } catch (e) {
      _showError('An error occurred. Please try again.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
