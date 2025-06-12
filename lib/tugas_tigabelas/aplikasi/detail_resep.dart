import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';

class DetailResep extends StatelessWidget {
  final Resep resep;

  const DetailResep({super.key, required this.resep});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF0F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Kategori: ${resep.kategori ?? '-'}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(resep.deskripsi ?? '-'),
            SizedBox(height: 10),
            Text(resep.langkah ?? '-'),
            SizedBox(height: 8),
            Text(resep.bahan ?? '-'),
          ],
        ),
      ),
    );
  }
}
