import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'sign_in_screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedRole = "Traveler";
  String? _selectedCountry;
  List<String> _countries = [];
  bool _isLoadingCountries = false;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    setState(() {
      _isLoadingCountries = true;
    });
    try {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
      if (response.statusCode == 200) {
        final List<dynamic> countryData = jsonDecode(response.body);
        setState(() {
          _countries = countryData
              .map((country) => country['name']['common'].toString())
              .toList();
          _countries.sort();
          _isLoadingCountries = false;
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      setState(() {
        _isLoadingCountries = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load countries: $e')),
      );
    }
  }

  Future<void> _registerUser() async {
    const String url = 'https://api-flutter-nper.onrender.com/api/user/';

    String fullName =
        '${_firstNameController.text} ${_lastNameController.text}';

    Map<String, dynamic> userData = {
      'name': fullName,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'countryName': _selectedCountry,
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
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      } else {
        final errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(errorData['message'] ?? 'Failed to register.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // Background xanh
                Container(
                  color: Color.fromARGB(250, 0, 206, 166),
                  width: double.infinity,
                  height: 890,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
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

                            // Radio cho Traveler và Guide
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

                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    'First Name',
                                    _firstNameController,
                                    (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: _buildTextField(
                                    'Last Name',
                                    _lastNameController,
                                    (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),

                            // DropdownSearch quốc gia
                            DropdownSearch<String>(
                              items: _countries,
                              selectedItem: _selectedCountry,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: 'Country',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: 'Search country...',
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCountry = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your country';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            _buildTextField(
                              'Email',
                              _emailController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              'Password',
                              _passwordController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            _buildTextField(
                              'Confirm Password',
                              _confirmPasswordController,
                              (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                            SizedBox(height: 20),

                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _registerUser();
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

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
