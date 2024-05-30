import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> _userFiles = [];

  @override
  void initState() {
    super.initState();
    _loadUserFiles();
  }

  Future<void> _loadUserFiles() async {
    if (_currentUser == null) return;

    final filesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('files');

    final filesSnapshot = await filesCollection.get();
    setState(() {
      _userFiles = filesSnapshot.docs
          .map((doc) => {
        'id': doc.id,
        'name': doc['name'],
        'url': doc['url'],
      })
          .toList();
    });
  }

  Future<void> _uploadFile() async {
    if (_currentUser == null) return;

    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = File(result.files.single.path!);
    final fileName = result.files.single.name;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_files')
          .child(_currentUser!.uid)
          .child(fileName);

      await ref.putFile(file);
      final fileUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('files')
          .add({
        'name': fileName,
        'url': fileUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully.')),
      );

      _loadUserFiles();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    }
  }

  Future<void> _deleteFile(String docId, String fileName) async {
    if (_currentUser == null) return;

    try {
      // Delete file from Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_files')
          .child(_currentUser!.uid)
          .child(fileName);

      await ref.delete();

      // Delete file metadata from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('files')
          .doc(docId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File deleted successfully.')),
      );

      _loadUserFiles();
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        // If the file doesn't exist in Firebase Storage, still delete the metadata from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_currentUser!.uid)
            .collection('files')
            .doc(docId)
            .delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File metadata deleted successfully.')),
        );

        _loadUserFiles();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete file: $e')),
        );
      }
    }
  }


  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      final ref = FirebaseStorage.instance.refFromURL(url);
      final bytes = await ref.getData();

      await file.writeAsBytes(bytes!);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File downloaded to ${file.path}')),
      );

      OpenFile.open(file.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Files'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: _uploadFile,
          ),
        ],
      ),
      body: _userFiles.isEmpty
          ? Center(child: Text('No files available.'))
          : ListView.builder(
        itemCount: _userFiles.length,
        itemBuilder: (context, index) {
          final file = _userFiles[index];
          return ListTile(
            title: Text(file['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () => _downloadFile(file['url'], file['name']),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteFile(file['id'], file['name']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
