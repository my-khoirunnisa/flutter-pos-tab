import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_pos_tab_custom/core/extentions/string_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/home/models/product_quantity.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/variables.dart';

class OrderMenuPayment extends StatelessWidget {
  final ProductQuantity data;
  const OrderMenuPayment({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColors.green, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 20,
                        backgroundImage: data.product.image != null
                            ? NetworkImage(
                                data.product.image!.contains('http')
                                    ? data.product.image!
                                    : '${Variables.baseUrl}/${data.product.image}',
                              )
                            : AssetImage(Assets.icons.categoryAll.path)),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.product.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      data.product.price!.toIntegerFromText.currencyFormatRp,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CheckoutBloc>()
                            .add(CheckoutEvent.removeItem(data.product));
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.green, width: 1),
                            shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.icons.minus.path,
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        data.quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CheckoutBloc>()
                            .add(CheckoutEvent.addItem(data.product));
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.green, width: 1),
                            shape: BoxShape.circle),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.icons.plus.path,
                            width: 10,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              (int.parse(data.product.price!.replaceAll('.', '')) *
                      data.quantity)
                  .currencyFormatRp,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
