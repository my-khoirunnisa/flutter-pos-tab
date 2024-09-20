// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_pos_tab_custom/core/extentions/string_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/home/dialogs/payment_success_dialog.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import '../bloc/bloc/order_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../models/product_quantity.dart';

class PaymentConfirmDialog extends StatelessWidget {
  final String totalPriceController;
  const PaymentConfirmDialog({
    super.key,
    required this.totalPriceController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(
                  Assets.icons.question.path,
                  width: 100,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: AppColors.darkGrey,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Is all the data correct?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please make sure the data is correct',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: 'No, check again',
                    borderRadius: 11,
                  ),
                ),
                const SizedBox(width: 15.0),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    final discount = state.maybeWhen(
                      orElse: () => 0,
                      loaded: (products, discount, tax, serviceCharge) {
                        if (discount == null) {
                          return 0;
                        }
                        return discount.value!
                            .replaceAll('.00', '')
                            .toIntegerFromText;
                      },
                    );

                    final price = state.maybeWhen(
                      orElse: () => 0,
                      loaded: (products, discount, tax, service) =>
                          products.fold(
                        0,
                        (previousValue, element) =>
                            previousValue +
                            (element.product.price!.toIntegerFromText *
                                element.quantity),
                      ),
                    );
                    final subTotal = price - (discount / 100 * price);
                    final totalDiscount = discount / 100 * price;
                    final finalTax = subTotal * 0.11;

                    List<ProductQuantity> items = state.maybeWhen(
                      orElse: () => [],
                      loaded: (products, discount, tax, service) => products,
                    );
                    final totalQty = items.fold(
                        0,
                        (previousValue, element) =>
                            previousValue + element.quantity);

                    final totalPrice = subTotal + finalTax;

                    return Flexible(
                      child: Button.filled(
                        onPressed: () async {
                          context.read<OrderBloc>().add(
                                OrderEvent.order(
                                  items,
                                  discount,
                                  finalTax.toInt(),
                                  0,
                                  totalPriceController.toIntegerFromText,
                                ),
                              );
                          Navigator.pop(context);
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return PaymentSuccessDialog(
                                data: items,
                                totalQty: totalQty,
                                totalPrice: totalPrice.toInt(),
                                totalTax: finalTax.toInt(),
                                totalDiscount: totalDiscount.toInt(),
                                subTotal: subTotal.toInt(),
                                normalPrice: price,
                              );
                            },
                          );
                        },
                        label: 'Yes, continue',
                        borderRadius: 11,
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
