import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/core/extentions/build_context_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/pages/discount_page.dart';
import 'package:flutter_pos_tab_custom/presentation/home/dialogs/logout_confirm_dialog.dart';
import 'package:flutter_pos_tab_custom/presentation/home/pages/home_page.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/nav_item.dart';
import 'package:flutter_pos_tab_custom/presentation/report/pages/report_page.dart';
import 'package:flutter_pos_tab_custom/presentation/setting/pages/setting_page.dart';

import '../../auth/pages/login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ReportPage(),
    const DiscountPage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                height: context.deviceHeight - 20.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.17),
                      offset: const Offset(0, 4),
                      blurRadius: 11,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 11.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'POS',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24.0),
                        ),
                      ),
                    ),
                    NavItem(
                      iconPath: Assets.icons.menuHome.path,
                      label: 'Home',
                      isActive: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                    ),
                    NavItem(
                      iconPath: Assets.icons.menuReport.path,
                      label: 'Report',
                      isActive: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                    ),
                    NavItem(
                      iconPath: Assets.icons.menuDiscount.path,
                      label: 'Discount',
                      isActive: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                    ),
                    NavItem(
                      iconPath: Assets.icons.menuSettings.path,
                      label: 'Settings',
                      isActive: _selectedIndex == 3,
                      onTap: () => _onItemTapped(3),
                    ),
                    NavItem(
                      iconPath: Assets.icons.menuLogout.path,
                      label: 'Logout',
                      isActive: false,
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const LogoutConfirmDialog();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _pages[_selectedIndex])
          ],
        ),
      ),
    );
  }
}
