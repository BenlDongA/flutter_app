import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Để sử dụng jsonEncode
import 'sign_up_screen.dart';
import '../main.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Hàm đăng nhập sử dụng API
  void _signIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.get(
        Uri.parse('https://api-flutter-nper.onrender.com/api/user'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> users = jsonDecode(response.body);

        // Tìm người dùng
        var user = users.firstWhere(
            (user) => user['email'] == email && user['password'] == password,
            orElse: () => null);

        if (user != null) {
          // Đăng nhập thành công, điều hướng và truyền dữ liệu người dùng
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(
                initialIndex: 2,
                userData: {
                  'name': user['name'],
                  'email': user['email'],
                  'password': user['password'],
                  '_id': user['_id'],
                },
              ),
            ),
          );
        } else {
          _showErrorDialog(context, 'Email hoặc mật khẩu không đúng.');
        }
      } else {
        _showErrorDialog(context, 'Login failed: ${response.statusCode}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Có lỗi xảy ra: ${error.toString()}');
    }
  }

  void _navigateToSignUp(BuildContext context) {
    // Điều hướng đến màn hình đăng ký
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void _navigateBack(BuildContext context) {
    // Điều hướng về màn hình trước đó
    Navigator.pop(context);
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateBack(context);
        return false; // Ngăn chặn quay lại
      },
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00CEA6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nút Back
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => _navigateBack(context),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 246, 245, 245),
                                  width: 2),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 130, 0, 0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(250, 50)),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 30, right: 30, top: 30),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding:
                                  EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: Text(
                                'Welcome back, Yoo Jin',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  _buildTextFormField(
                                    'Email',
                                    _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email.';
                                      }
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  _buildTextFormField(
                                    'Password',
                                    _passwordController,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password.';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Hành động cho "Forgot Password"
                                      },
                                      child: Text('Forgot Password'),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () => _signIn(context),
                                    child: Text('SIGN IN'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      backgroundColor: Color(0xFF00CEA6),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text('or sign in with'),
                                  SizedBox(height: 10),
                                  _buildSocialMediaButtons(),
                                  SizedBox(height: 20),
                                  _buildSignUpLink(context),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label, TextEditingController controller,
      {bool obscureText = false, String? Function(String?)? validator}) {
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
      validator: validator,
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialMediaButton('lib/images/facebook.jpg'),
        _buildSocialMediaButton('lib/images/kakao.jpg'),
        _buildSocialMediaButton('lib/images/line.jpg'),
      ],
    );
  }

  Widget _buildSocialMediaButton(String assetPath) {
    return IconButton(
      onPressed: () {
        // Hành động khi nhấn vào biểu tượng mạng xã hội
      },
      icon: Image.asset(
        assetPath,
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? "),
        GestureDetector(
          onTap: () => _navigateToSignUp(context),
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
