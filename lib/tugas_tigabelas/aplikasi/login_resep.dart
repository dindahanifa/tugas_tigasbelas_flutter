import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/homepage_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/list_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/register_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/dbhelper/dbhelper_user.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_user.dart';

class LoginResepmakanan extends StatefulWidget {
  const LoginResepmakanan({super.key});
  static const String id = "/login_screen_app";
  @override
  State<LoginResepmakanan> createState() => _LoginResepmakananState();
}

class _LoginResepmakananState extends State<LoginResepmakanan> {
  bool isVisibility = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(children: [buildBackground(), buildLayer()]),
      ),
    );
  }

  SafeArea buildLayer() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              height(12),
              Text(
                "Login to access your account",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              height(24),
              buildTitle("Email Address"),
              height(12),
              buildTextField(
                hintText: "Enter your email",
                controller: emailController,
              ),
              height(16),
              buildTitle("Password"),
              height(12),
              buildTextField(
                hintText: "Enter your password",
                isPassword: true,
                controller: passwordController,
              ),
              height(12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PendataanResep()),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              height(24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    final userData = await DbHelper.getEmailandPassword(
                      emailController.text,
                      passwordController.text,
                    );
                    if (userData != null) {
                     print('data ada: ${userData.toMap()}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login successful")),
                      );
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => HomepageResep()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email atau password salah")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Or Sign In With",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 8),

                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              height(16),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/RegisResepmakanan");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/image/google.png",
                        height: 16,
                        width: 16,
                      ),
                      width(4),
                      Text("Google"),
                    ],
                  ),
                ),
              ),
              height(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisResepmakanan.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white
    );
  }

  Widget buildTextField({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      obscureText: isPassword ? isVisibility : false,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
        suffixIcon:
            isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisibility = !isVisibility;
                    });
                  },
                  icon: Icon(
                    isVisibility ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
                : null,
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);
  SizedBox width(double width) => SizedBox(width: width);

  Widget buildTitle(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}