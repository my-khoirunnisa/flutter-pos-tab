import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final List<String> tabIcons;
  final int initialTabIndex;
  final List<Widget> tabView;
  const CustomTabBar({
    super.key,
    required this.tabTitles,
    required this.tabIcons,
    required this.initialTabIndex,
    required this.tabView,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialTabIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(
              widget.tabTitles.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: _selectedIndex == index
                        ? AppColors.green
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        widget.tabIcons[index],
                        width: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.tabTitles[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, left: 16, right: 16),
          child: Text(
            'Choose Menu.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: widget.tabView[_selectedIndex],
        )
      ],
    );
  }
}
