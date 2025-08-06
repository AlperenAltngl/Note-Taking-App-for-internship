import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_voice/pages/add_new_task_page.dart';
import 'package:todo_app_with_voice/pages/setting_page.dart';
import 'package:todo_app_with_voice/todo_provider.dart';
import 'package:todo_app_with_voice/theme_provider.dart';
import 'package:todo_app_with_voice/todo_card.dart';
import 'package:todo_app_with_voice/no_notes.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Settings button - Top Left
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.settings, size: 20),
                      color: Colors.grey[600],
                      onPressed: () {
                        navigateToSettings(context);
                      },
                      splashRadius: 20,
                    ),
                  ),
                  // Completed Tasks button - Top Right
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                      color: Provider.of<DarkThemeProvider>(context).isDarkMode
                          ? Colors.amber
                          : Colors.blue,
                    ),
                    child: TextButton.icon(
                      icon: Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Completed',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      onPressed: () {
                        print('Completed tasks clicked');
                        // TODO: Implement completed tasks functionality
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Main content area
            Expanded(
              child: Consumer<ToDoProvider>(
                builder: (context, todoProvider, child) {
                  if (todoProvider.isNotesEmpty) {
                    return const NoNotes();
                  }
                  return ListView.builder(
                    itemCount: todoProvider.toDoList.length,
                    itemBuilder: (context, index) => TodoCard(
                      todo: todoProvider.toDoList[index],
                      index: index,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Add new task clicked');
            navigateAddNewTaskPage(context);
          },
          backgroundColor: Provider.of<DarkThemeProvider>(context).isDarkMode
              ? Colors.amber
              : Theme.of(context).primaryColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
