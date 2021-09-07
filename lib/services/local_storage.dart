import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  final String fileName;

  LocalStorage({this.fileName});

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      bool fileExist = await file.exists();

      if (fileExist) {
        String content = await file.readAsString();
        return content;
      } else {
        return null;
      }
    } catch (e) {
      throw (e);
    }
  }

  Future<File> writeContent(content) async {
    final file = await _localFile;
    return file.writeAsString(content);
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
