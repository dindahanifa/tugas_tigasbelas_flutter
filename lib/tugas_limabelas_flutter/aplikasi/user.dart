import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/api/api_login.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/aplikasi/profil.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/helper.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/shared_preferences.dart';

class Limabelas extends StatefulWidget {
  const Limabelas({super.key});

  @override
  State<Limabelas> createState() => _LimabelasState();
}

class _LimabelasState extends State<Limabelas> {
  final UserService userService = UserService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSignIn = true;
  bool _obscurePassword = true;
  bool isLoading = false;

  bool _isEmailValid(String email) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(email);
  }

  void _handleSignIn() async {
    setState(() => isLoading = true);

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Username dan Password tidak boleh kosong.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
      setState(() => isLoading = false);
      return;
    }

    try {
      final loginRequest = await userService.login(
        _emailController.text,
        _passwordController.text,
      );

      if (loginRequest["data"] != null) {
        final token = loginRequest["data"]['token'];
        final user = loginRequest["data"]['user'];

        PreferenceHandler.saveToken(token);

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('nama', user['nama']);
        prefs.setString('email', user['email']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login berhasil!"),
            backgroundColor: Colors.white,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilScreen()),
        );
      } else if (loginRequest["errors"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Maaf, ${loginRequest["message"]}"),
            backgroundColor: Colors.white,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: $e"),
          backgroundColor: Colors.white,
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void _handleSignUp() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua kolom tidak boleh kosong.')),
      );
      return;
    }

    if (!_isEmailValid(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Format email tidak valid')),
      );
      return;
    }

    try {
      final registerRequest = await userService.register(
        _emailController.text,
        _usernameController.text,
        _passwordController.text,
      );

      if (registerRequest["data"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Register berhasil!",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ));
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            isSignIn = true;
            _usernameController.clear();
            _emailController.clear();
            _passwordController.clear();
          });
        });
      } else if (registerRequest["errors"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Maaf, ${registerRequest["message"]}",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi kesalahan: $e"),
        backgroundColor: Colors.white,
      ));
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('assets/image/hello.png', fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                children: [
                  SizedBox(height: 250),
                  _buildAuthTabs(),
                  SizedBox(height: 40),
                  isSignIn ? _buildSignForm() : _buildSignUpForm(),
                  SizedBox(height: 30),
                  if (isSignIn)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget your password?',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAuthTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => setState(() => isSignIn = true),
          child: _buildTapButton('SIGN IN', isSignIn),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: () => setState(() => isSignIn = false),
          child: _buildTapButton('SIGN UP', !isSignIn),
        ),
      ],
    );
  }

  Widget _buildTapButton(String text, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(3, 3),
                  blurRadius: 6,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(-3, -3),
                  blurRadius: 6,
                ),
              ]
            : [],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputField(IconData icon, String hintText, bool isPassword,
      TextEditingController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(-3, -3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            offset: Offset(3, 3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.white.withOpacity(0.5)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white.withOpacity(0.7),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSignForm() {
    return Column(
      children: [
        _buildInputField(Icons.person, 'Email', false, _emailController),
        SizedBox(height: 20),
        _buildInputField(Icons.lock, 'Password', true, _passwordController),
        SizedBox(height: 40),
        _buildAuthButton('SIGN IN', _handleSignIn),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        _buildInputField(Icons.person, 'Username', false, _usernameController),
        SizedBox(height: 20),
        _buildInputField(Icons.email, 'Email', false, _emailController),
        SizedBox(height: 20),
        _buildInputField(Icons.lock, 'Password', true, _passwordController),
        SizedBox(height: 40),
        _buildAuthButton('SIGN UP', _handleSignUp),
      ],
    );
  }

  Widget _buildAuthButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [Color(0xFFB0D9EE), Color(0xFF86B9E7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(4, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
