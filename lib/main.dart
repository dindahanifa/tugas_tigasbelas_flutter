import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/login_resepmakanan.dart';
import 'package:tugas_tigasbelas_flutter/regis_resepmakanan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        //Harus didaftarkan dulu disini
        "/": (context) => LoginResepmakanan(),
        "/RegisResepmakanan": (context) => RegisResepmakanan(),
      },
      debugShowCheckedModeBanner: false,
      title: 'PPKD B 2',

      theme: ThemeData(
        // useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder()},
        ),
      ),
      // home: LoginScreen(),
    );
  }
}