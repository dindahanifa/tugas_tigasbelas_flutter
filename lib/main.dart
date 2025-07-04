import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/pertemuan_22/user_list_screen.dart';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/aplikasi/list_screen_postusers.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/aplikasi/user.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/list_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/login_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/register_resep.dart';

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
        // "/": (context) => LoginResepmakanan(),
        // "/RegisResepmakanan": (context) => RegisResepmakanan(),
        // "/PendataanResep": (context) => PendataanResep(),
        // "ListResep": (context) => ListResep(),
        "/": (context) => Limabelas(),
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