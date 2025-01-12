import 'package:flutter/material.dart';

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({
    super.key,
    required this.theme,
    required this.tabs,
    required this.controller,
  });

  final ColorScheme theme;
  final List<Widget> tabs;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.only(top: 0, bottom: 20, left: 30, right: 0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(10),
        ),

        // tab bar
        child: TabBar(
          enableFeedback: true,
          splashBorderRadius: BorderRadius.circular(20),
          dividerHeight: 0,
          tabs: tabs,
          controller: controller,
        ),

        //
      ),
    );
  }
}
