import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../bloc/transaction_report/transaction_report_bloc.dart';

class FilterTabBar extends StatefulWidget {
  final List<String> tabTitles;
  final int initialTabIndex;
  final List<Widget> tabView;
  final bool? report;
  const FilterTabBar({
    super.key,
    required this.tabTitles,
    required this.initialTabIndex,
    required this.tabView,
    this.report = false,
  });

  @override
  State<FilterTabBar> createState() => _FilterTabBarState();
}

class _FilterTabBarState extends State<FilterTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialTabIndex;
    context.read<TransactionReportBloc>().add(TransactionReportEvent.getReport(
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: List.generate(
              widget.tabTitles.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if (widget.report!) {
                    if (_selectedIndex == 0) {
                      context.read<TransactionReportBloc>().add(
                          TransactionReportEvent.getReport(
                              startDate: DateTime.now()
                                  .subtract(const Duration(days: 1)),
                              endDate: DateTime.now()));
                    }
                    if (_selectedIndex == 1) {
                      context.read<TransactionReportBloc>().add(
                          TransactionReportEvent.getReport(
                              startDate: DateTime.now()
                                  .subtract(const Duration(days: 7)),
                              endDate: DateTime.now()));
                    }
                    if (_selectedIndex == 2) {
                      context.read<TransactionReportBloc>().add(
                          TransactionReportEvent.getReport(
                              startDate: DateTime.now()
                                  .subtract(const Duration(days: 30)),
                              endDate: DateTime.now()));
                    }
                  }
                },
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? AppColors.green
                          : AppColors.grey,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      widget.tabTitles[index],
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: _selectedIndex == index
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    )),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: widget.tabView[_selectedIndex],
        )
      ],
    );
  }
}
