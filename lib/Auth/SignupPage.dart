import 'package:effecient/Auth/loginPage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effecient/Auth/SignupPage.dart';
import 'package:effecient/Auth/HomePage.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _errorText = '';
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  void initState() {
    super.initState();

    // Add listeners to text controllers
    _usernameController.addListener(updateErrorText);
    _emailController.addListener(updateErrorText);
    _passwordController.addListener(updateErrorText);
    _confirmPasswordController.addListener(updateErrorText);
  }

  void updateErrorText() {
    // Reset error text
    setState(() {
      _errorText = '';
    });

    // Check for empty fields
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorText = 'All fields are required';
      });
      return;
    }

    // Check if password and confirm password match
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorText = 'Passwords do not match';
      });
      return;
    }

    // Check if email has valid format
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      setState(() {
        _errorText = 'Invalid email format';
      });
      return;
    }
  }

  Future<void> _register() async {
    final String username = _usernameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    // Reset error text
    setState(() {
      _errorText = '';
    });

    // Check for empty fields
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _errorText = 'All fields are required';
      });
      return;
    }

    // Check if password and confirm password match
    if (password != confirmPassword) {
      setState(() {
        _errorText = 'Passwords do not match';
      });
      return;
    } else {
      // Clear the error if passwords match
      setState(() {
        _errorText = '';
      });
    }

    // Check if email has valid format
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      setState(() {
        _errorText = 'Invalid email format';
      });
      return;
    }

    try {
      // Check if email already exists
      final emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (emailQuery.docs.isNotEmpty) {
        setState(() {
          _errorText = 'Email is already registered';
        });
        return;
      }

      // Check if username already exists
      final usernameQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (usernameQuery.docs.isNotEmpty) {
        setState(() {
          _errorText = 'Username is already taken';
        });
        return;
      }

      // Create user
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save username to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'username': username, 'email': email});

      // Saving the profile Data into the Provider
      Provider.of<chDataProvider>(context, listen: false).userEmail = email;
      Provider.of<chDataProvider>(context, listen: false).userName = username;
      Provider.of<chDataProvider>(context, listen: false).profileFetchingDone =
          true;

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Navigate to another page after successful registration
      // You can replace 'MyTabScreen' with the name of the screen you want to navigate to
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(user: userCredential.user)));
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Login'),
        // ),
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            color: Colors.black, // Set the background color to black
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/add-user.png',
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ), // Add some space between the image and the first name bar
                    TextField(
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF707070),
                        prefixIcon:
                            Icon(Icons.person_rounded, color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorText:
                            _errorText.contains('Username') ? _errorText : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF707070),
                        prefixIcon: Icon(Icons.mail, color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorText:
                            _errorText.contains('Email') ? _errorText : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF707070),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        errorText:
                            _errorText.contains('Password') ? _errorText : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _isObscure2,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF707070),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                        ),
                        errorText: _errorText.contains('Passwords do not match')
                            ? _errorText
                            : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                    if (_errorText.isNotEmpty &&
                        !_errorText.contains('Username') &&
                        !_errorText.contains('Email') &&
                        !_errorText.contains('Password') &&
                        !_errorText.contains('Passwords do not match'))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _errorText,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                    Material(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff56CDED),
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: _register,
                        child: const Text("Sign up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("I have an Account? ",
                            style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: 15,
                              color: Colors.white,
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color: Color(0xff56CDED),
                                fontWeight: FontWeight.w600,
                                fontSize: 19),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
