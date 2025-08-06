import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'todo_data.dart';

class FileOperations {
  static Future<Directory> getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  static Future<File> getFile(String filename) async {
    final dir = await getDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

  static Future<File> writeToFile(String filename, String contents) async {
    final file = await getFile(filename);
    return file.writeAsString(contents);
  }

  static Future<File> writeTodoToFile(String filename, TodoData todo) async {
    final file = await getFile(filename);
    final jsonString = jsonEncode(todo.toJson());
    return file.writeAsString(jsonString);
  }

  static Future<String?> readFromFile(String filename) async {
    try {
      final file = await getFile(filename);
      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Deletes a file named [filename] in the documents directory
  static Future<bool> deleteFile(String filename) async {
    try {
      final file = await getFile(filename);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
