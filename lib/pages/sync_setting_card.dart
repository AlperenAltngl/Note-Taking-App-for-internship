import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_with_voice/theme_provider.dart';

class SyncSettingCard extends StatelessWidget {
  const SyncSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).isDarkMode;
    final Color iconBgColor = isDark ? Colors.grey[800]! : Colors.blue[100]!;
    final Color iconColor = isDark ? Colors.amber : Colors.blue[700]!;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(
              Icons.sync,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sync',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Save or load your data',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onSelected: (String value) {
              String message = value == 'save' ? 'Save selected' : 'Load selected';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'save',
                child: Text('Save'),
              ),
              PopupMenuItem<String>(
                value: 'load',
                child: Text('Load'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}