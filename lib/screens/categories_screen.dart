import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = ['Computers', 'History', 'General'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            title: Text(category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BooksByCategoryScreen(category: category)),
              );
            },
          );
        },
      ),
    );
  }
}

class BooksByCategoryScreen extends StatelessWidget {
  final String category;

  BooksByCategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books: $category'),
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(), // Replace with fetchBooksByCategory(category) if you implement category-based fetching
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final books = snapshot.data?.where((book) => book.category == category).toList() ?? [];
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookDetailScreen(bookId: book.id)),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
