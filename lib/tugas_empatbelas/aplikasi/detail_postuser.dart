import 'package:flutter/material.dart';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/model/model_postusers.dart';

class DetailPostuser extends StatelessWidget {
  final PostUser post;

  const DetailPostuser({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16), 
            width: double.infinity,
                        decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffCB0404), width: 2), 
                        borderRadius: BorderRadius.circular(12), 
                        color: Colors.white, 
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
            ),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
                          Text('ID: ${post.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                          SizedBox(height: 8),
                          Text('Title:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(post.title ?? ''),
                          SizedBox(height: 16),
                          Text('Body:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(post.body ?? '', textAlign: TextAlign.justify,),
                        ],
            ),
                            ),
          ),
        ),
    );
  }
}
