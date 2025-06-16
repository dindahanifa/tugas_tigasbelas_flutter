import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/detail_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/login_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/profil_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/dbhelper/dbhelper_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';

class ListResep extends StatefulWidget {
  const ListResep({super.key});

  @override
  State<ListResep> createState() => _ListResepState();
}

class _ListResepState extends State<ListResep> {
  List<Resep> daftarResep = [];
  List<Resep> daftarResepFiltered = [];
  String? nama;
  String? email;

  @override
  void initState() {
    super.initState();
    muatData();
    loadUserData();
  }

  Future<void> muatData() async {
    final data = await DbhelperResep.getAllResep();
    setState(() {
      daftarResep = data;
      daftarResepFiltered = data;
    });
  }

  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? 'Nama Pengguna';
      email = prefs.getString('email') ?? 'email@contoh.com';
    });
  }

  void filterResep(String query) {
    final filtered = daftarResep.where((resep) {
      final judulLower = resep.judul.toLowerCase();
      final kategoriLower = resep.kategori?.toLowerCase() ?? '';
      final searchLower = query.toLowerCase();
      return judulLower.contains(searchLower) || kategoriLower.contains(searchLower);
    }).toList();

    setState(() {
      daftarResepFiltered = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFAAAA),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu),
          ),
        ),
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari resep',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              filterResep(value);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PendataanResep(),
                ),
              );
              await muatData();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xffFFAAAA)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/koki.jpg'),
              ),
              accountName: Text(nama ?? ''),
              accountEmail: Text(email ?? ''),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text('Profil', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilResep()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.alarm,
                color: Colors.black,
              ),
              title: Text('Resep terakhir diliat', style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text('Pengaturan', style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Icon(
                Icons.key,
                color: Colors.black,
              ),
              title: Text('Keluar', style: TextStyle(fontSize: 20)),
              onTap: () async {
                final keluar = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Keluar'),
                    content: Text('Apakah anda yakin ingin keluar?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('Keluar'),
                      ),
                    ],
                  ),
                );
                if (keluar == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginResepmakanan()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffFFAAAA),
      body: daftarResepFiltered.isEmpty
          ? Center(child: Text("Belum ada resep"))
          : ListView.builder(
              itemCount: daftarResepFiltered.length,
              itemBuilder: (context, index) {
                final resep = daftarResepFiltered[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailResep(resep: resep),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: resep.gambarUrl != null && resep.gambarUrl!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                resep.gambarUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[200],
                                    alignment: Alignment.center,
                                    child: Icon(Icons.broken_image, color: Colors.grey),
                                  );
                                },
                              ),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: Icon(Icons.image, color: Colors.grey),
                            ),
                      title: Text(resep.judul),
                      subtitle: Text(resep.kategori ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PendataanResep(resep: resep),
                                ),
                              );
                              await muatData();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              bool? konfirmasi = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Konfirmasi Hapus'),
                                  content: Text('Apakah anda yakin menghapus resep ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text(
                                        'Hapus',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (konfirmasi == true) {
                                await DbhelperResep.deleteResep(resep.id!);
                                await muatData();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
