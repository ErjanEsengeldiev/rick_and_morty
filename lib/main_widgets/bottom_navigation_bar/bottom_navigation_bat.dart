import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final Function(int currentPageIndex)? onTap;
  final int currentIndex;

  const AppBottomNavigationBar({
    super.key,
    this.onTap,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: 'Герои',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Эпизоды',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
