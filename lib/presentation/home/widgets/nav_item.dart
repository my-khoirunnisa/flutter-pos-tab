import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            color: isActive ? AppColors.grey : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: SvgPicture.asset(
                    iconPath,
                    // colorFilter: isActive
                    //     ? ColorFilter.mode(
                    //         color,
                    //         BlendMode.srcIn,
                    //       )
                    //     : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    // color: isActive ? Colors.white : Colors.black,
                    color: Colors.black,
                    fontSize: 13.0,
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
