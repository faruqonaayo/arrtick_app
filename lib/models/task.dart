class Task {
  final String id;
  final String title;
  final String note;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endTime;
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
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
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
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isChecked': isChecked,
      'priority': priority,
      'projectId': projectId,
    };
  }
}
