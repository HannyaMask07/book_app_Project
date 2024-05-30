import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/book.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId;

  BookDetailScreen({required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: FutureBuilder<Book>(
        future: fetchBookDetails(bookId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final book = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(book.author, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  SizedBox(height: 16),
                  Text(book.description),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
