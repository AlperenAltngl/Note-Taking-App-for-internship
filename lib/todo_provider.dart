import 'package:flutter/foundation.dart';
import 'package:todo_app_with_voice/todo_data.dart';
import 'package:todo_app_with_voice/file_operations.dart';
import 'dart:convert';

class ToDoProvider extends ChangeNotifier {
  static const String _fileName = 'todos.json';
  List<TodoData> _toDoList = [];
  bool _isLoaded = false;

  ToDoProvider() {
    _loadToDos();
  }

  Future<void> _loadToDos() async {
    final jsonString = await FileOperations.readFromFile(_fileName);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _toDoList = decoded.map((e) => TodoData.fromJson(e)).toList();
      } catch (e) {
        _toDoList = [];
      }
    } else {
      _toDoList = [];
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _saveToDos() async {
    final jsonString = jsonEncode(_toDoList.map((e) => e.toJson()).toList());
    await FileOperations.writeToFile(_fileName, jsonString);
  }

  Future<void> addToDo(TodoData newTask) async {
    final wasEmpty = _toDoList.isEmpty;
    _toDoList.add(newTask);
    await _saveToDos();
    if (wasEmpty != _toDoList.isEmpty) {
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  Future<void> deleteToDo(int index) async {
    final wasEmpty = _toDoList.isEmpty;
    _toDoList.removeAt(index);
    await _saveToDos();
    if (wasEmpty != _toDoList.isEmpty) {
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  List<TodoData> get toDoList => _toDoList;

  bool get isNotesEmpty => _toDoList.isEmpty;

  bool get isLoaded => _isLoaded;

  Future<void> reload() async {
    await _loadToDos();
  }
}