import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'explone/explore_screen.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'mess/messages_screen.dart';
import 'trip/trips_screen.dart';
import 'Signin_Signup/sign_in_sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ẩn thanh trạng thái và thanh điều hướng
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt nhãn "debug"
      home: SplashScreen(), // Màn hình splash hiển thị trước
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Thời gian chờ 7 giây
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Lottie.asset(
          'lib/images/loading.json',
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bg_welcome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Nội dung overlay
          Column(
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 20),
                child: Text(
                  'LIFE IS SHORT\nAND THE WORLD IS WIDE',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInSignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final int initialIndex;
  final Map<String, dynamic> userData; // Thêm dòng này

  MainScreen(
      {Key? key,
      this.initialIndex = 0,
      required this.userData}) // Cập nhật constructor
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return [
      ExploreScreen(),
      TripsScreen(),
      HomePage(),
      MessagesScreen(),
      ProfilePage(userData: widget.userData), // Truyền userData vào ProfilePage
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions()[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
