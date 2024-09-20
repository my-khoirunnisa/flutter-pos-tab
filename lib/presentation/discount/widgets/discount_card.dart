import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/data/model/discount_response_model.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/models/discount_model.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';

class DiscountCard extends StatelessWidget {
  final Discount data;
  final VoidCallback onTap;
  const DiscountCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 50,
                height: 45,
                decoration: const BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.edit.path,
                    width: 18,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
              child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.light,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${data.value!.replaceAll('.00', '')}%',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
            ),
          )),
          // const Spacer(),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              data.name ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
