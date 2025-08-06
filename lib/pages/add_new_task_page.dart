import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import '../todo_data.dart';
import '../todo_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

enum Periodicity { yearly, monthly, weekly, daily }

class AddNewTaskPage extends StatefulWidget {
  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Periodicity? _selectedPeriodicity;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    // Combine date and time
    DateTime finalDate = selectedDate!;
    if (selectedTime != null) {
      finalDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
    }

    // Convert periodicity to string
    String periodicity = 'Once';
    if (_selectedPeriodicity != null) {
      switch (_selectedPeriodicity) {
        case Periodicity.yearly:
          periodicity = 'Yearly';
          break;
        case Periodicity.monthly:
          periodicity = 'Monthly';
          break;
        case Periodicity.weekly:
          periodicity = 'Weekly';
          break;
        case Periodicity.daily:
          periodicity = 'Daily';
          break;
        default:
          periodicity = 'Once';
      }
    }

    // Create new task
    TodoData newTask = TodoData(
      title: _titleController.text,
      description: _notesController.text.isEmpty ? 'No description' : _notesController.text,
      date: finalDate,
      periodicity: periodicity,
    );

    // Add to provider
    Provider.of<ToDoProvider>(context, listen: false).addToDo(newTask);

    // Navigate back
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<DarkThemeProvider>(context).isDarkMode;
    final Color cardColor = isDark ? Colors.grey[900]! : Colors.white;
    final Color fieldColor = isDark ? Colors.grey[800]! : Colors.grey[200]!;
    final Color accentColor = isDark ? Colors.amber : Colors.blue;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Custom Header
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Rounded Back Button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 20),
                      color: Colors.grey[600],
                      onPressed: () => Navigator.of(context).pop(),
                      splashRadius: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Add New Task',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Main content area
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64),
                child: Card(
                  color: cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Task Title",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            fillColor: fieldColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Enter task title',
                          ),
                        ),
                        SizedBox(height: 12),
                        // AI Voice Data Entry Button (Placeholder)
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implement AI voice data entry utility
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('AI voice data entry coming soon!')),
                              );
                            },
                            icon: Icon(Icons.mic, color: accentColor),
                            label: Text(
                              'AI Voice Data Entry',
                              style: TextStyle(color: accentColor, fontWeight: FontWeight.w600),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: accentColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Date Picker
                            Column(
                              children: [
                                Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(
                                  selectedDate != null
                                      ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                                      : "No date selected",
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                ),
                                SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accentColor,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: Text("Select Date"),
                                ),
                              ],
                            ),
                            // Time Picker
                            Column(
                              children: [
                                Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text(
                                  selectedTime != null
                                      ? selectedTime!.format(context)
                                      : "No time selected",
                                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                ),
                                SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () => _selectTime(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: accentColor,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  ),
                                  child: Text("Select Time"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        // Slidable Notes Text Field
                        Slidable(
                          key: ValueKey('notes_field'),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  setState(() {
                                    _notesController.clear();
                                  });
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Clear',
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _notesController,
                            minLines: 3,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              hintText: 'Enter notes for this task',
                              fillColor: fieldColor,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: Icon(Icons.notes, color: accentColor),
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        // Periodicity Dropdown
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Periodicity",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                color: fieldColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: DropdownButton<Periodicity>(
                                value: _selectedPeriodicity,
                                isExpanded: true,
                                hint: Text("Select period"),
                                underline: SizedBox(),
                                items: Periodicity.values.map((period) {
                                  String label = period.toString().split('.').last;
                                  label = label[0].toUpperCase() + label.substring(1);
                                  return DropdownMenuItem<Periodicity>(
                                    value: period,
                                    child: Text(label),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPeriodicity = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _saveTask,
                            icon: Icon(Icons.check_circle_outline, color: Colors.black),
                            label: Text(
                              "Save Task",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateAddNewTaskPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddNewTaskPage()),
  );
}
