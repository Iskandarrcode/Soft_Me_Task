import 'package:flutter/material.dart';
import 'package:soft_me/ui/screens/home_screen/home_screen.dart';
import 'package:soft_me/ui/screens/managements_screens/managements_screen.dart';

class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key});

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  int curIndex = 0;
  List<Widget> pages = [
    const HomeScreen(),
    const Placeholder(),
    const Placeholder(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(139, 44, 79, 107),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  curIndex == 0 ? Colors.grey[800] : Colors.grey[500],
                ),
              ),
              onPressed: () {
                curIndex = 0;
                setState(() {});
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  curIndex == 1 ? Colors.grey[800] : Colors.grey[500],
                ),
              ),
              onPressed: () {
                curIndex = 1;
                setState((){});
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  curIndex == 2 ? Colors.grey[800] : Colors.grey[500],
                ),
              ),
              onPressed: () {
                curIndex = 2;
                setState(() {});
              },
              icon: const Icon(
                Icons.star_border_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  curIndex == 3 ? Colors.grey[800] : Colors.grey[500],
                ),
              ),
              onPressed: () {
                curIndex = 3;
                setState(() {});
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: pages[curIndex],
    );
  }
}
