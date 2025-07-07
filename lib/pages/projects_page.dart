import 'package:flutter/material.dart';
import '../widgets/project_tile.dart';
import 'add_projects.dart';
import '../models/project.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final List<Project> _projects = [];

  Future<void> _addProject() async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (context) => const AddProjectsPage()),
    );
    if (result != null && result['title'] != null && result['title'].toString().isNotEmpty) {
      setState(() {
        _projects.add(Project(
          title: result['title'],
          description: result['description'],
          iconCodePoint: result['iconCodePoint'],
          iconFontFamily: result['iconFontFamily'],
        ));
      });
    }
  }

  void _deleteProject(int idx) {
    setState(() {
      _projects.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: _projects.isEmpty
        ? const Center(
            child: Text(
              'Track your projects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              final double w = constraints.maxWidth;
              final double half = (w - 48) / 2; // 16px padding each side, 16px gap
              final double full = w - 32; // 16px padding each side
              final double gap = 16;

              List<Widget> tiles = [];
              double y = 0;
              int i = 0;
              while (i < _projects.length) {
                // 1. Square (left)
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: 0,
                    top: y,
                    width: half,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 1,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 2. Square (left, below previous)
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: 0,
                    top: y + half + gap,
                    width: half,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 1,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 3. Tall (right, spanning two squares)
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: half + gap,
                    top: y,
                    width: half,
                    height: half * 2 + gap,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 0.5,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 4. Long (full width, below previous row)
                y += half * 2 + gap * 2;
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: 0,
                    top: y,
                    width: full,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 2,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 5. Square (left, below long)
                y += half + gap;
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: 0,
                    top: y,
                    width: half,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 1,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 6. Square (right, beside previous)
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: half + gap,
                    top: y,
                    width: half,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 1,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                // 7. Long (full width, below previous row)
                y += half + gap;
                if (i < _projects.length) {
                  final idx = i;
                  tiles.add(Positioned(
                    left: 0,
                    top: y,
                    width: full,
                    height: half,
                    child: ProjectTile(
                      title: _projects[i].title,
                      description: _projects[i].description,
                      color: Colors.primaries[i % Colors.primaries.length].shade100,
                      icon: _projects[i].icon,
                      subtitle: '${_projects[i].taskCount} Tasks',
                      aspectRatio: 2,
                      completedTasks: _projects[i].completedTasks,
                      taskCount: _projects[i].taskCount,
                      onDelete: () => _deleteProject(idx),
                    ),
                  ));
                  i++;
                }
                y += half + gap;
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: y,
                  child: Stack(children: tiles),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}