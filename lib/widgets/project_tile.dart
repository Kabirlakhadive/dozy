import 'package:flutter/material.dart';

class ProjectTile extends StatelessWidget {
  final String title;
  final String? description;
  final Color color;
  final IconData icon;
  final String? subtitle;
  final double aspectRatio;
  final int completedTasks;
  final int taskCount;
  final VoidCallback? onDelete;

  const ProjectTile({
    Key? key,
    required this.title,
    this.description,
    required this.color,
    required this.icon,
    this.subtitle,
    this.aspectRatio = 1.0,
    this.completedTasks = 0,
    this.taskCount = 0,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        child: Stack(
          children: [
            // Icon at top left
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(10),
                child: Icon(icon, size: 26, color: Colors.amber.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 12,
              child: Text(subtitle ?? '', style: const TextStyle(fontSize: 13, color: Colors.black54)),
            ),
            // Delete button (top right)
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                onPressed: onDelete,
                tooltip: 'Delete Project',
              ),
            ),
            // Completed tasks circle (bottom right)
            Positioned(
              bottom: 12,
              right: 12,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$completedTasks/$taskCount',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
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
