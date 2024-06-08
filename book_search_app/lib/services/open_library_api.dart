import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class OpenLibraryApi {
  static const String _baseUrl = 'https://openlibrary.org/search.json';

  static Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> docs = data['docs'];

      return docs.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar livros');
    }
  }
}
