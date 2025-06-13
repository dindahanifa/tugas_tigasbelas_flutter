import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/detail_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/login_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/profil_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/register_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/dbhelper/dbhelper_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';

class ListResep extends StatefulWidget {
  const ListResep({super.key});

  @override
  State<ListResep> createState() => _ListResepState();
}

class _ListResepState extends State<ListResep> {
  List<Resep> daftarResep = [];
  String? nama;
  String? email;

  @override
  Future<void> muatData() async {
    final data = await DbhelperResep.getAllResep();
    setState(() {
      daftarResep = data;
    });
  }

  @override
  void initState() {
    muatData();
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? 'Nama Pengguna';
      email = prefs.getString('email') ?? 'eamil@contoh.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFAAAA),
        leading: Builder(
          builder: (context)=> IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu),
            )),
        actions: [IconButton(
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
        ),],
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
                    accountEmail: Text(email ?? '')
                    ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.black,),
                title: Text('Profil',style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=> ProfilResep()));
                },
              ),
              ListTile(
                leading: Icon(Icons.alarm, color: Colors.black,),
                title: Text('Resep terakhir diliat',style: TextStyle(fontSize: 20)),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.black,),
                title: Text('Pengaturan',style: TextStyle(fontSize: 20)),
              ),  
              ListTile(
                leading: Icon(Icons.key, color: Colors.black,),
                title: Text('Keluar',style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context)=> LoginResepmakanan()), 
                    (Route)=> false);
                },
              ),   
          ],
        ),
      ),
      backgroundColor: Color(0xffFFAAAA),
      body: daftarResep.isEmpty
          ? Center(child: Text("Belum ada resep"))
          : ListView.builder(
              itemCount: daftarResep.length,
              itemBuilder: (context, index) {
                final resep = daftarResep[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context)=> DetailResep(resep: resep)));
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child : ListTile(
                      leading: CircleAvatar(
                        backgroundImage: resep.gambarUrl != null && resep.gambarUrl!.isNotEmpty
                            ? NetworkImage(resep.gambarUrl!)
                            : null,
                        child: resep.gambarUrl == null || resep.gambarUrl!.isEmpty
                            ? Icon(Icons.image)
                            : null,
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
                              await DbhelperResep.deleteResep(resep.id!);
                              await muatData();
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
