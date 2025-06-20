import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  final String baseUrl = 'https://absen.quidi.id/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Accept': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal login: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Accept': 'application/json'},
      
      body: { 
        'email': email,
        'name': username,
        'password': password
      },
    );
    if (response.statusCode == 201){
      return json.decode(response.body);
    } else {
      throw Exception('Gagal registrasi: ${response.statusCode} - ${response.body}');
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 204;
  }
}
