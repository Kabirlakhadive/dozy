class Task {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? startTime;
  final String? endTime;
  final String? project;

  Task({
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.startTime,
    this.endTime,
    this.project,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? 'High',
      dueDate: map['dueDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      project: map['project'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'dueDate': dueDate,
      'startTime': startTime,
      'endTime': endTime,
      'project': project,
    };
  }
}
