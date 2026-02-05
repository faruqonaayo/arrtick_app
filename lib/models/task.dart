
class Task {
  final String id;
  final String title;
  final String note;
  final DateTime startDate;
  final String startTime;
  final String endTime;
  final bool isChecked;
  final String priority;
  final String projectId;

  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    this.isChecked = false,
    required this.priority,
    required this.projectId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      note: json['note'],
      startDate: DateTime.parse(json['startDate']),
      startTime: json['startTime'],
      endTime: json['endTime'],
      isChecked: json['isChecked'],
      priority: json['priority'],
      projectId: json['projectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'startDate': startDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'isChecked': isChecked,
      'priority': priority,
      'projectId': projectId,
    };
  }
}
