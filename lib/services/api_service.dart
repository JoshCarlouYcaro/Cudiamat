import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String endpoint = 'https://jsonplaceholder.typicode.com/users';

  Future<List<dynamic>> getUsers() async {
    try {
      final response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }
}