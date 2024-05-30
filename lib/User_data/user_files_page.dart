import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class UserFilesPage extends StatefulWidget {
  @override
  _UserFilesPageState createState() => _UserFilesPageState();
}

class _UserFilesPageState extends State<UserFilesPage> {
  late String userId;
  List<FileSystemEntity> files = [];

  @override
  void initState() {
    super.initState();
    getUserFiles();
  }


  Future<void> getUserFiles() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid; // Use user UID as the directory name
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final Directory userDir = Directory('${appDocDir.path}/User_data/$userId');

      if (await userDir.exists()) {
        setState(() {
          files = userDir.listSync();
        });
      } else {
        await userDir.create(recursive: true);
      }
    }
  }

  void _openFile(File file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Files'),
      ),
      body: files.isEmpty
          ? Center(child: Text('No files available.'))
          : ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          final File file = files[index] as File;
          return ListTile(
            title: Text(file.path.split('/').last),
            trailing: IconButton(
              icon: Icon(Icons.download),
              onPressed: () => _openFile(file),
            ),
          );
        },
      ),
    );
  }
}
