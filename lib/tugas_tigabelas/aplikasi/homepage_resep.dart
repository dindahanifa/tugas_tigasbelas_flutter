import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/list_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/pendataan_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/aplikasi/profil_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';

class HomepageResep extends StatefulWidget {
  const HomepageResep({super.key});

  @override
  State<HomepageResep> createState() => _HomepageResepState();
}

class _HomepageResepState extends State<HomepageResep> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptipons = <Widget>[
    ListResep(),
    ProfilResep(),
  ];

  @override 
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    print("Halaman saat ini : $_selectedIndex");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ClipOval(child: Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.white),),
                ),
                SizedBox(height: 5,),
                Text('dinda hanifa', style: TextStyle(fontSize: 16)),
                Text('dinda.h33@gmail.com', style: TextStyle(fontSize: 16)),
                ],
              ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.black,),
                title: Text('Profil',style: TextStyle(fontSize: 20)),
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
              ),   
          ],
        ),
      ),
        
        body: _widgetOptipons[_selectedIndex], 
    );
  }
}