import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

Future<List<Book>> fetchBooks() async {
  final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=flutter&key=AIzaSyDI-D0FKRExsyxbNerjuNxhhgSw7yPzPWI'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['items'];
    return jsonResponse.map((book) => Book.fromJson(book['volumeInfo'])).toList();
  } else {
    throw Exception('Failed to load books');
  }
}

Future<Book> fetchBookDetails(String id) async {
  final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes/$id?key=AIzaSyDI-D0FKRExsyxbNerjuNxhhgSw7yPzPWI'));

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body)['volumeInfo']);
  } else {
    throw Exception('Failed to load book details');
  }
}
