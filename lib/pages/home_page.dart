import 'package:dozy/widgets/summary_widgets.dart';
import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;
  int _currentPage = 2;
  final ScrollController _scrollController = ScrollController();

  final List<String> summaryTitles = [
    'This is your progress this week',
    'You have 10 completed tasks.',
    'You have 14 tasks today.',
    'You have 22 tasks this week.',
    'You have 40 tasks this month.',
  ];

  Future<void> _addTask() async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (context) => const AddTaskPage()),
    );
    if (result != null && result['title'] != null && result['title'].toString().isNotEmpty) {
      context.read<TaskProvider>().addTask(Task.fromMap(result));
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Color _backgroundColor(double shrinkOffset, double maxExtent) {
    if (shrinkOffset >= maxExtent) {
      return const Color(0xFFBBDEFB);
    }
    final t = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    return Color.lerp(Colors.white, const Color(0xFFBBDEFB), t)!;
  }

  @override
  Widget build(BuildContext context) {
    final double topSectionMaxHeight = MediaQuery.of(context).size.height * 0.25;
    final double topSectionMinHeight = 0;
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
    double maxExtent = topSectionMaxHeight;
    Color bgColor = _backgroundColor(scrollOffset, maxExtent);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dozy', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: bgColor,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          setState(() {}); // To trigger rebuild for background color
          return false;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0.0;
            double maxExtent = topSectionMaxHeight;
            Color bgColor = _backgroundColor(scrollOffset, maxExtent);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: bgColor,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: _AnimatedHeaderDelegate(
                      minExtent: topSectionMinHeight,
                      maxExtent: topSectionMaxHeight,
                      pageController: _pageController,
                      currentPage: _currentPage,
                      summaryTitles: summaryTitles,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFBBDEFB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height ,
                          ),
                          child: Consumer<TaskProvider>(
                            builder: (context, taskProvider, _) {
                              final tasks = taskProvider.tasks;
                              return tasks.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: Center(
                                      child: Text(
                                        'Start your day now!',
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                : ListView(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    children: tasks.asMap().entries.map((entry) {
                                      final idx = entry.key;
                                      final task = entry.value;
                                      return TaskTile(
                                        title: task.title,
                                        description: task.description,
                                        priority: task.priority,
                                        dueDate: task.dueDate,
                                        startTime: task.startTime,
                                        endTime: task.endTime,
                                        project: task.project,
                                        onDelete: () async {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              title: const Text('Delete Task'),
                                              content: const Text('Are you sure you want to delete this task?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                  ),
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirm == true) {
                                            context.read<TaskProvider>().removeTask(idx);
                                          }
                                        },
                                      );
                                    }).toList(),
                                  );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final PageController pageController;
  final int currentPage;
  final List<String> summaryTitles;
  final ValueChanged<int> onPageChanged;

  _AnimatedHeaderDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.pageController,
    required this.currentPage,
    required this.summaryTitles,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double percent = 1.0 - (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final double opacity = percent;
    final double scale = 0.8 + 0.2 * percent;
    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: summaryTitles.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    child: SummaryWidget(title: summaryTitles[index]),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                summaryTitles.length,
                (index) => Container(
                  width: 3,
                  height: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _AnimatedHeaderDelegate oldDelegate) {
    return oldDelegate.currentPage != currentPage ||
        oldDelegate.summaryTitles != summaryTitles ||
        oldDelegate.pageController != pageController;
  }
}
