import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_voice/theme_provider.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final darkThemeProvider = Provider.of<DarkThemeProvider>(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkThemeProvider.isDarkMode 
                    ? Colors.amber[500] 
                    : Colors.blue[500],
              ),
              child: const Icon(Icons.add, size: 32, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Text(
                  'Welcome to your notes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: darkThemeProvider.isDarkMode 
                        ? Colors.grey[300] 
                        : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Start by adding your first task',
                  style: TextStyle(
                    fontSize: 14,
                    color: darkThemeProvider.isDarkMode 
                        ? Colors.grey[400] 
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}