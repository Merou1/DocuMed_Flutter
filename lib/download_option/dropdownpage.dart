import 'package:flutter/material.dart';
import 'download_page.dart';

class DropdownPage extends StatefulWidget {
  @override
  _DropdownPageState createState() => _DropdownPageState();
}

class _DropdownPageState extends State<DropdownPage> {
  String? _selectedOption;
  List<String> _options = ['Option1', 'Option2', 'Option3']; // Example options without extensions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedOption,
              hint: Text('Select an option'),
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: _selectedOption != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DownloadPage(option: _selectedOption!),
                  ),
                );
              }
                  : null,
              child: Text('Go to Download Page'),
            ),
          ],
        ),
      ),
    );
  }
}
