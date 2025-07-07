import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: Colors.deepPurple.shade100,
              alignment: Alignment.center,
              child: const Text(
                'You have 4 tasks today.',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: 
                ListView(
                  children: const [
                    TaskTile(title: 'Task 1', subtitle: 'This is the first task'),
                    TaskTile(title: 'Task 2', subtitle: 'This is the second task'),
                    TaskTile(title: 'Task 3', subtitle: 'This is the third task'),
                    TaskTile(title: 'Task 4', subtitle: 'This is the fourth task'),
                    TaskTile(title: 'Task 5', subtitle: 'This is the fifth task'),
                    TaskTile(title: 'Task 6', subtitle: 'This is the sixth task'),
                    TaskTile(title: 'Task 7', subtitle: 'This is the seventh task'),
                    TaskTile(title: 'Task 8', subtitle: 'This is the eighth task'),
                    TaskTile(title: 'Task 9', subtitle: 'This is the ninth task'),
                    TaskTile(title: 'Task 10', subtitle: 'This is the tenth task'),
                  ],
                ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
