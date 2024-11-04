import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/common/helpers.dart';
import 'package:mangadex_flutter/features/home/more_page.dart';

class HomePage extends ConsumerStatefulWidget {
  final int? initialTab;

  const HomePage({super.key, this.initialTab});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _bottomIcons = const [
    Icons.collections_bookmark_outlined,
    Icons.update_outlined,
    Icons.history_outlined,
    Icons.more_horiz_outlined
  ];
  final _bottomActiveIcons = const [
    Icons.collections_bookmark,
    Icons.update,
    Icons.history,
    Icons.more_horiz
  ];
  final _bottomLabels = const ["Library", "Update", "History", "More"];

  late final PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialTab ?? 0);
    currentIndex = widget.initialTab ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            controller: _pageController,
            children: [Text("1"), Text("2"), Text("3"), MorePage()]),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              _pageController.jumpToPage(value);
              currentIndex = value;
              setState(() {});
            },
            items: _bottomIcons
                .mapIndexed((icon, index) => BottomNavigationBarItem(
                    icon: Icon(icon),
                    activeIcon: Icon(_bottomActiveIcons[index]),
                    label: _bottomLabels[index]))
                .toList()));
  }
}