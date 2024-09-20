import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';

class BankTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final List<String> tabIcons;
  final int initialTabIndex;
  const BankTabBar({
    super.key,
    required this.tabTitles,
    required this.tabIcons,
    required this.initialTabIndex,
  });

  @override
  State<BankTabBar> createState() => _BankTabBarState();
}

class _BankTabBarState extends State<BankTabBar> {
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
        Row(
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
                    border: Border.all(
                      width: 1,
                      color: AppColors.green,
                    )),
                child: Row(
                  children: [
                    Image.asset(
                      widget.tabIcons[index],
                      width: 30,
                    ),
                    const SizedBox(width: 10),
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
      ],
    );
  }
}
