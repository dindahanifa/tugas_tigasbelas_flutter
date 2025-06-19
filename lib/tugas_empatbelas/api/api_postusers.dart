import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tugas_tigasbelas_flutter/tugas_empatbelas/model/model_postusers.dart';

Future<List<PostUser>> getUsers() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');


  if (response.statusCode == 200) {
    final List<dynamic> userJson = jsonDecode(response.body);
    return userJson.map((e) => PostUser.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
}
