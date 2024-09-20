import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../bloc/bloc/order_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../models/product_quantity.dart';

class PaymentSuccessDialog extends StatefulWidget {
  final List<ProductQuantity> data;
  final int totalQty;
  final int totalPrice;
  final int totalTax;
  final int totalDiscount;
  final int subTotal;
  final int normalPrice;
  const PaymentSuccessDialog({
    super.key,
    required this.data,
    required this.totalQty,
    required this.totalPrice,
    required this.totalTax,
    required this.totalDiscount,
    required this.subTotal,
    required this.normalPrice,
  });

  @override
  State<PaymentSuccessDialog> createState() => _PaymentSuccessDialogState();
}

class _PaymentSuccessDialogState extends State<PaymentSuccessDialog> {
  // List<OrderItem> data = [];
  // int totalQty = 0;
  // int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: BoxDecoration(
                    color: AppColors.bgPaymentCard,
                    borderRadius: BorderRadius.circular(11)),
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    int paymentAmountNew = 0;
                    String paymentMethodNew = 'Cash';
                    int totalPriceNew = 0;
                    int diff = paymentAmountNew - widget.totalPrice;
                    state.maybeWhen(
                      orElse: () {
                        paymentAmountNew = 0;
                        paymentMethodNew = 'Cash';
                        totalPriceNew = 0;
                        diff = 0;
                      },
                      loaded: (orderModel) {
                        paymentAmountNew = orderModel.paymentAmount;
                        paymentMethodNew = orderModel.paymentMethod;
                        totalPriceNew = orderModel.total;
                        diff = paymentAmountNew - widget.totalPrice;
                      },
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withOpacity(0.5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppColors.green,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SvgPicture.asset(
                                Assets.icons.check.path,
                                // ignore: deprecated_member_use
                                color: Colors.black,
                                width: 50,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'Payment Success!!',
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 70),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DetailReceipt(
                                  label: 'Payment Method',
                                  value: paymentMethodNew,
                                ),
                                const SizedBox(height: 40),
                                _DetailReceipt(
                                  label: 'Nominal Payment',
                                  value:
                                      paymentAmountNew.ceil().currencyFormatRp,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _DetailReceipt(
                                  label: 'Total Amount',
                                  value: widget.totalPrice.currencyFormatRp,
                                ),
                                const SizedBox(height: 40),
                                _DetailReceipt(
                                  label: 'Return',
                                  value: diff.ceil().currencyFormatRp,
                                  useColor: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(DateFormat('dd MMMM yyyy, HH:mm')
                                .format(DateTime.now())),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
              Positioned(
                bottom: -20,
                left: 0,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 15),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 7),
                    itemCount: 9,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Flexible(
                child: Button.filled(
                  onPressed: () async {
                    context
                        .read<CheckoutBloc>()
                        .add(const CheckoutEvent.started());
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  label: 'Back to Home',
                  borderRadius: 11,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(width: 15.0),
              Flexible(
                child: Button.filled(
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  label: 'Print',
                  borderRadius: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailReceipt extends StatelessWidget {
  final String label;
  final String value;
  final bool useColor;
  const _DetailReceipt({
    required this.label,
    required this.value,
    this.useColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            // color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: useColor ? AppColors.primary : Colors.black,
            fontWeight: useColor ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
