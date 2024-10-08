import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import '../main.dart';

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
}

List<User> users = [
  User(email: 'cuong', password: '123'),
  // Thêm nhiều người dùng nếu cần
];

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  void _signIn(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    bool isValidUser =
        users.any((user) => user.email == email && user.password == password);

    if (isValidUser) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 2)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email hoặc mật khẩu không đúng.'),
          duration: Duration(seconds: 2),
        ),
      );

      _isEmailValid = email.isNotEmpty;
      _isPasswordValid = password.isNotEmpty;
      (context as Element).markNeedsBuild(); // Yêu cầu xây dựng lại giao diện
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
    // Điều hướng về màn hình Profile
    Navigator.pop(context); // Quay lại màn hình trước đó
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
                            onPressed: () => _navigateBack(
                                context), // Quay về màn hình trước
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
                                _buildTextField(
                                    'Email', _emailController, !_isEmailValid),
                                SizedBox(height: 20),
                                _buildTextField('Password', _passwordController,
                                    !_isPasswordValid,
                                    obscureText: true),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Tạo hành động cho "Forgot Password"
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool hasError,
      {bool obscureText = false}) {
    return TextField(
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
        errorText: hasError ? 'This field cannot be empty' : null,
      ),
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
        // Thực hiện hành động khi nhấn vào biểu tượng mạng xã hội
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
