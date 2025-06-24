import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/helper.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/model/model_profil';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/model/model_regis.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/model/model_register_error.dart';
import 'package:tugas_tigasbelas_flutter/tugas_limabelas_flutter/shared_preferences.dart';

class UserService {
  final String baseUrl = 'https://absen.quidi.id/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      return registerRequestRegisterRequestFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErrorFromJson(response.body).toJson();
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
        'password': password,
      },
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return registerRequestRegisterRequestFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErrorFromJson(response.body).toJson();
    } else {
      throw Exception('Gagal registrasi: ${response.statusCode} - ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    String? token = await PreferenceHandler.getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan, silahkan login ulang');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      return profileResponseFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErrorFromJson(response.body).toJson();
    } else {
      print("Gagal memuat profil: ${response.statusCode}");
      throw Exception("Gagal memuat profil: ${response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> updateProfile(String name) async {
    String? token = await PreferenceHandler.getToken();
    if (token == null){
      throw  Exception('Token tidak ditemukan, silahkan login ulang');
    }
    final response = await http.put(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        
      },
       body: {
        'name': name,
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      return profileResponseFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registerErrorFromJson(response.body).toJson();
    } else {
      print("Gagal memuat profil: ${response.statusCode}");
      throw Exception("Gagal memuat profil: ${response.statusCode}");
    }
  }
}
