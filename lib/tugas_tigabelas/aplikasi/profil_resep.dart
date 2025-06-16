import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilResep extends StatefulWidget {
  static const String id = '/ProfilResep';

  const ProfilResep({super.key});

  @override
  State<ProfilResep> createState() => _ProfilResepState();
}

class _ProfilResepState extends State<ProfilResep> {
  String? username;
  String? nama;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Username';
      nama = prefs.getString('nama') ?? 'Nama Pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          username ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.orangeAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/image/koki.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Text('Resep', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('0'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Text('Pengikut', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('1055'),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: const [
                      Text('Mengikuti', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('5'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(nama ?? '', style: const TextStyle(fontSize: 15)),
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.transparent),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Resep'),
                Text('Recook'),
                Text('Tips'),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
