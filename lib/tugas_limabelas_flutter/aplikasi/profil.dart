import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/api/api_login.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/aplikasi/user.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/helper.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final UserService userService = UserService();
  String? username = 'Nama Pengguna';
  String? email = 'email@contoh.com';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('nama') ?? 'Nama Pengguna';
      email = prefs.getString('email') ?? 'email@contoh.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          Column(
            children: [
              buildTopSection(context),
              const SizedBox(height: 20),
              Expanded(child: _buildMenuOptions()),
            ],
          ),
        ],
      ),
    );
  }

  /// Background menggunakan Positioned.fill agar memenuhi Stack
  Widget buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// Bagian atas dengan SafeArea dan informasi pengguna
  Widget buildTopSection(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final keluar = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Apakah anda yakin ingin keluar?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Keluar'),
                          ),
                        ],
                      ),
                    );

                    if (keluar == true) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/image/koki.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              username ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              email ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  ///  Menu bawah: Edit profil, Setting, Help
  Widget _buildMenuOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(Icons.person, 'Edit Profil', () {
            print('Edit Profil');
          }),
          const Divider(indent: 20, endIndent: 20, color: Colors.black),
          _buildMenuItem(Icons.settings, 'Setting', () {
            print('Setting');
          }),
          const Divider(indent: 20, endIndent: 20, color: Colors.black),
          _buildMenuItem(Icons.help, 'Help', () {
            print('Help');
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color?.withOpacity(0.1) ?? Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color ?? Colors.black),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
