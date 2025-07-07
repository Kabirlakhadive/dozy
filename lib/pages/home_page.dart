import 'package:dozy/widgets/summary_widgets.dart';
import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    // Animate from white to 0xFFBBDEFB as the header shrinks
    final t = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    return Color.lerp(Colors.white, const Color(0xFFBBDEFB), t)!;
  }

  @override
  Widget build(BuildContext context) {
    final double topSectionMaxHeight = MediaQuery.of(context).size.height * 0.25;
    final double topSectionMinHeight = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        backgroundColor: Colors.transparent,
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
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            TaskTile(title: 'Task 1', description: 'This is the first task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 2', description: 'This is the second task', priority: 'Medium', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 3', description: 'This is the third task', priority: 'Low', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 4', description: 'This is the fourth task', priority: 'Low', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 5', description: 'This is the fifth task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 6', description: 'This is the sixth task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 7', description: 'This is the seventh task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 8', description: 'This is the eighth task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 9', description: 'This is the ninth task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                            TaskTile(title: 'Task 10', description: 'This is the tenth task', priority: 'High', dueDate: '2025-01-01', startTime: '10:00', endTime: '11:00'),
                          ],
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AnimatedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
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
