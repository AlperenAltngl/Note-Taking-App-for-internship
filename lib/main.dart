import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_voice/notes_home.dart';
import 'package:todo_app_with_voice/theme_provider.dart';
import 'package:todo_app_with_voice/todo_provider.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: Builder(
        builder: (context) {
          final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
          return MaterialApp(
            title: 'Notes App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: darkThemeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: NotesHomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

