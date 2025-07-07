import 'package:flutter/material.dart';

class Project {
  final String title;
  final String? description;
  final int taskCount;
  final int completedTasks;
  final int iconCodePoint;
  final String iconFontFamily;

  Project({
    required this.title,
    this.description,
    this.taskCount = 0,
    this.completedTasks = 0,
    this.iconCodePoint = 0xe2c7, // default: folder
    this.iconFontFamily = 'MaterialIcons',
  });

  IconData get icon => IconData(iconCodePoint, fontFamily: iconFontFamily);

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'] ?? '',
      description: map['description'],
      taskCount: map['taskCount'] ?? 0,
      completedTasks: map['completedTasks'] ?? 0,
      iconCodePoint: map['iconCodePoint'] ?? 0xe2c7,
      iconFontFamily: map['iconFontFamily'] ?? 'MaterialIcons',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'taskCount': taskCount,
      'completedTasks': completedTasks,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
    };
  }
}
