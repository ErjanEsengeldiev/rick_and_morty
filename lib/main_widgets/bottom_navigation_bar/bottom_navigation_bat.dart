import 'package:flutter/material.dart';
import 'package:rick_and_morty/generated/l10n.dart';

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
      items: [
        BottomNavigationBarItem(
          label: S.of(context).characters,
          icon: const Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: S.of(context).episods,
          icon: const Icon(Icons.movie),
        ),
      ],
    );
  }
}
