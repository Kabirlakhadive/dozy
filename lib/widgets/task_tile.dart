import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? startTime;
  final String? endTime;
  final String? project;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.startTime,
    this.endTime,
    this.project,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF232325),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: priority == 'High'
                            ? Colors.red.shade400
                            : priority == 'Medium'
                                ? Colors.yellow.shade600
                                : Colors.green.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        priority,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (project != null && project!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Project: $project',
                        style: const TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                    if ((startTime != null && startTime!.isNotEmpty) || (endTime != null && endTime!.isNotEmpty)) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.white70, size: 12),
                          const SizedBox(width: 6),
                          Text(
                            '${startTime ?? ''}${(startTime != null && endTime != null && endTime!.isNotEmpty) ? ' - ' : ''}${endTime ?? ''}',
                            style: const TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                    if (dueDate != null && dueDate!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'Due Date: ',
                            style: TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                          Text(
                            dueDate!,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              // Vertical divider
              const VerticalDivider(
                color: Colors.white,
                thickness: 1.5,
                width: 24,
                indent: 0,
                endIndent: 0,
              ),
              // Delete button centered vertically
              Center(
                child: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                  onPressed: onDelete,
                  tooltip: 'Delete',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
