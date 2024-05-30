import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class DownloadPage extends StatelessWidget {
  final String option;

  DownloadPage({required this.option});

  final User? _currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _downloadFile(BuildContext context) async {
    if (_currentUser == null) return;

    final fileName = '$option.pdf'; // Append .pdf to the selected option

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_files')
          .child(_currentUser!.uid)
          .child(fileName);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      // Check if file exists in Firebase Storage
      final exists = await ref.getDownloadURL().catchError((error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download file: $error')),
        );
        return null;
      });

      if (exists == null) {
        return; // File does not exist, exit the function
      }

      final bytes = await ref.getData();

      await file.writeAsBytes(bytes!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File downloaded to ${file.path}')),
      );

      OpenFile.open(file.path);
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _downloadFile(context),
          child: Text('Download $option'),
        ),
      ),
    );
  }
}
