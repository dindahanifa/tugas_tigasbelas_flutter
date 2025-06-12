import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/detail_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/profil_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/homepage_resep.dart';
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
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Image.asset("assets/image/always.png"),
        ),
        actions: [IconButton(
          icon: Icon(Icons.add, color: Colors.white),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PendataanResep(),
              ),
            );
            await muatData();
          },
        ),]
      ),
      backgroundColor: Colors.white,
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
