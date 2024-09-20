import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/extentions/build_context_ext.dart';

import '../../../core/constants/colors.dart';

class MenuPrinterButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const MenuPrinterButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: context.deviceWidth,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppColors.green : AppColors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
