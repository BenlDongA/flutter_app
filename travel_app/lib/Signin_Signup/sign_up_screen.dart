import 'dart:convert'; // Để xử lý JSON
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'sign_in_screen.dart'; // Import màn hình Sign In

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedRole = "Traveler";

  Future<void> _registerUser() async {
    const String url = 'https://api-flutter-nper.onrender.com/api/user/';

    // Tạo trường name từ firstName và lastName
    String fullName =
        '${_firstNameController.text} ${_lastNameController.text}';

    // Dữ liệu đăng ký, bao gồm countryName
    Map<String, dynamic> userData = {
      'name': fullName,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'countryName': _countryController.text, // Đảm bảo gửi countryName
      'email': _emailController.text,
      'password': _passwordController.text,
      'role': _selectedRole,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userData), // Chuyển đổi userData thành JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${errorData['message']}')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Failed to register')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Ngăn chặn quay lại
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Khung màu xanh
                Container(
                  color: Color.fromARGB(250, 0, 206, 166),
                  width: double.infinity,
                  height: 890,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nút Back
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // Quay về màn hình trước
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFF6F5F5),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'lib/images/logo.png',
                            width: 32.22,
                            height: 38,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 130,
                  left: 0,
                  right: 0,
                  height: 890,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(250, 50)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Join us as a Traveler or Guide',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 30),

                            // Nút radio cho Traveler và Guide
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Traveler'),
                                    value: 'Traveler',
                                    groupValue: _selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedRole = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Guide'),
                                    value: 'Guide',
                                    groupValue: _selectedRole,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedRole = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // Row cho First Name và Last Name
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                      'First Name',
                                      _firstNameController,
                                      'Please enter your first name'),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildTextField(
                                      'Last Name',
                                      _lastNameController,
                                      'Please enter your last name'),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            _buildTextField('Country', _countryController,
                                'Please enter your country'),
                            SizedBox(height: 20),
                            _buildTextField('Email', _emailController,
                                'Please enter your email',
                                emailValidation: true),
                            SizedBox(height: 20),
                            _buildTextField('Password', _passwordController,
                                'Please enter your password',
                                obscureText: true),
                            SizedBox(height: 20),

                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _registerUser(); // Gọi hàm đăng ký khi hợp lệ
                                  }
                                },
                                child: Text('SIGN UP'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                  backgroundColor: Color(0xFF00CEA6),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // Sử dụng Navigator.push để chuyển sang màn hình Sign In
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
                                  );
                                },
                                child: Text('Already have an account? Sign In'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng trường nhập liệu
  Widget _buildTextField(
      String label, TextEditingController controller, String errorMsg,
      {bool obscureText = false, bool emailValidation = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorMsg;
        }
        if (emailValidation &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
