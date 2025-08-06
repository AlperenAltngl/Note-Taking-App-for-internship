

class TodoData {
  final String title;
  final String description;
  final DateTime date;
  final String periodicity;

  TodoData({
    required this.title,
    required this.description,
    required this.date,
    required this.periodicity,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'periodicity': periodicity,
      };

  factory TodoData.fromJson(Map<String, dynamic> json) => TodoData(
        title: json['title'] as String,
        description: json['description'] as String,
        date: DateTime.parse(json['date'] as String),
        periodicity: json['periodicity'] as String,
      );
}