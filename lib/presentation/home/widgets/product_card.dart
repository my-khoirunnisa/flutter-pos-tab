import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/constants/variables.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_pos_tab_custom/core/extentions/string_ext.dart';
import 'package:flutter_pos_tab_custom/data/model/product_response_model.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
        },
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    loaded: (items, discount, tax, serviceCharge) {
                      return items.any((element) => element.product == data)
                          ? items
                                      .firstWhere(
                                          (element) => element.product == data)
                                      .quantity >
                                  0
                              ? Positioned(
                                  top: -8,
                                  left: -8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          offset: const Offset(0, 5),
                                          blurRadius: 11,
                                          spreadRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          items
                                              .firstWhere((element) =>
                                                  element.product == data)
                                              .quantity
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                          : const SizedBox();
                    },
                  );
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.light,
                          backgroundImage: data.image != null
                              ? NetworkImage(
                                  data.image!.contains('http')
                                      ? data.image!
                                      : '${Variables.baseUrl}/${data.image}',
                                )
                              : AssetImage(Assets.icons.categoryAll.path)),
                    ),
                  ),
                  // const Spacer(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      data.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      data.price!.toIntegerFromText.currencyFormatRp,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        width: 45,
                        height: 37,
                        decoration: const BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.icons.plus.path,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
