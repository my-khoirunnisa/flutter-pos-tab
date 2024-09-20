import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_svg/svg.dart';

class CashierInfo extends StatelessWidget {
  final String name;
  const CashierInfo({
    super.key, required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Text(
              'Cashier',
              style: TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(11.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            Assets.icons.profile.path,
            colorFilter: null,
          ),
        )
      ],
    );
  }
}
