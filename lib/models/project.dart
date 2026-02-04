class Project {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime estimatedEndDate;
  final DateTime? endDate;
  final bool isCompleted;
  final bool isFavorite;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.estimatedEndDate,
    this.endDate,
    this.isCompleted = false,
    this.isFavorite = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      estimatedEndDate: DateTime.parse(json['estimatedEndDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCompleted: json['isCompleted'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'estimatedEndDate': estimatedEndDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCompleted': isCompleted,
      'isFavorite': isFavorite,
    };
  }
}
