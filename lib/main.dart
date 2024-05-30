import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/books_future_builder_screen.dart';
import 'screens/books_dynamic_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/options_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = ThemeData.light();
  double _fontSize = 14.0;

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  void _toggleTheme() {
    setState(() {
      _themeData = (_themeData == ThemeData.light()) ? ThemeData.dark() : ThemeData.light();
    });
  }

  void _updateFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
    _saveFontSize(fontSize);
  }

  void _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? 14.0;
    });
  }

  void _saveFontSize(double fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: _themeData.copyWith(
        textTheme: ThemeData.light().textTheme.apply(fontSizeFactor: _fontSize / 14.0),
      ),
      home: HomeScreen(toggleTheme: _toggleTheme, updateFontSize: _updateFontSize),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final Function(double) updateFontSize;

  HomeScreen({required this.toggleTheme, required this.updateFontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book App Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BooksFutureBuilderScreen()),
                );
              },
              child: Text('FutureBuilder Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BooksDynamicScreen()),
                );
              },
              child: Text('Dynamic Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
                );
              },
              child: Text('Categories Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OptionsScreen(onFontSizeChanged: updateFontSize)),
                );
              },
              child: Text('Options Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
