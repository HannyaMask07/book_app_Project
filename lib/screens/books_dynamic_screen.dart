import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/book.dart';
import 'book_detail_screen.dart';

class BooksDynamicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books (Dynamic)'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BooksDynamicScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return BooksDynamicView(books: snapshot.data ?? []);
          }
        },
      ),
    );
  }
}

class BooksDynamicView extends StatefulWidget {
  final List<Book> books;

  BooksDynamicView({required this.books});

  @override
  _BooksDynamicViewState createState() => _BooksDynamicViewState();
}

class _BooksDynamicViewState extends State<BooksDynamicView> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text('Grid View'),
          value: isGrid,
          onChanged: (value) {
            setState(() {
              isGrid = value;
            });
          },
        ),
        Expanded(
          child: isGrid ? buildGridView() : buildListView(),
        ),
      ],
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        final book = widget.books[index];
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

  Widget buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        final book = widget.books[index];
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookDetailScreen(bookId: book.id)),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(book.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(book.author),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
