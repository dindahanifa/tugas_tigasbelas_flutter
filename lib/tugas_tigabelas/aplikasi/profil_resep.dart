import 'package:flutter/material.dart';

class ProfilResep extends StatefulWidget {
   static const String id = '/ProfilResep';

  const ProfilResep({super.key});

  @override
  State<ProfilResep> createState() => _ProfilResepState();
}

class _ProfilResepState extends State<ProfilResep> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "din_haf",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),

// Foto
      backgroundColor:Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:[Colors.pink, Colors.orangeAccent], 
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ClipOval(
                        child: Image.asset('assets/image/koki.jpg', fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  ),
        
        // Posting, Mengikuti, Pengikut
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                      Padding(padding: EdgeInsets.only(left: 90, top: 25)),
                      Text('Resep', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                      Text('0', style: TextStyle(color: Colors.black),),
                        ]
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 90, top: 25)),
                      Text('Pengikut', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('1055'),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 90, top: 25)),
                      Text('Mengikuti', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                      Text('5')
                    ],
                  )
                ],
              ),
              ),
              SizedBox(height: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20),
                  child: Text('Dinda Hanifa', style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
        
        // Garis Horizontal
              SizedBox(height: 5,),
              Divider(
                color: Colors.transparent,
                thickness: 0.5,
              ),
        
        // Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Resep'),
                  Text('Recook'),
                  Text('Tips')
                ],
              ),
        
        // Garis
              SizedBox(height: 5,),
              Divider(
                color: Colors.black,
                thickness: 0.5,
              ),
          ],
        ),
      ),
    );
  }
}