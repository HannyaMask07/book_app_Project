import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsScreen extends StatefulWidget {
  final Function(double) onFontSizeChanged;

  OptionsScreen({required this.onFontSizeChanged});

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  double _fontSize = 14.0;

  @override
  void initState() {
    super.initState();
    _loadFontSize();
  }

  // Load the font size from SharedPreferences
  void _loadFontSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('fontSize') ?? 14.0;
    });
  }

  // Save the font size to SharedPreferences
  void _saveFontSize(double fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
    widget.onFontSizeChanged(fontSize);
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('About This App'),
          content: Text('Version: 1.0.0\nAuthor: Your Name\nThis is a simple book app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Font Size', style: TextStyle(fontSize: _fontSize)),
            Slider(
              value: _fontSize,
              min: 10,
              max: 30,
              divisions: 20,
              label: _fontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                });
                _saveFontSize(value);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showAboutDialog,
              child: Text('About This App'),
            ),
          ],
        ),
      ),
    );
  }
}
