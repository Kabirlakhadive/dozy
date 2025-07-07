import 'package:flutter/material.dart';

const List<IconData> projectIcons = [
  Icons.folder,
  Icons.lightbulb_outline,
  Icons.auto_graph,
  Icons.extension,
  Icons.web,
  Icons.phone_android,
  Icons.code,
  Icons.book,
  Icons.check_circle_outline,
];

class AddProjectsPage extends StatefulWidget {
  const AddProjectsPage({Key? key}) : super(key: key);

  @override
  State<AddProjectsPage> createState() => _AddProjectsPageState();
}

class _AddProjectsPageState extends State<AddProjectsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  int _iconIndex = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_titleController.text.trim().isNotEmpty) {
      Navigator.of(context).pop({
        'title': _titleController.text.trim(),
        'description': _descController.text.trim(),
        'iconCodePoint': projectIcons[_iconIndex].codePoint,
        'iconFontFamily': projectIcons[_iconIndex].fontFamily ?? 'MaterialIcons',
      });
    }
  }

  void _nextIcon() {
    setState(() {
      _iconIndex = (_iconIndex + 1) % projectIcons.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(projectIcons[_iconIndex], size: 36, color: Colors.amber.shade700),
                  onPressed: _nextIcon,
                  tooltip: 'Change Icon',
                ),
              ],
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Project Title',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }
}
