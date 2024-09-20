import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../../discount/bloc/discount/discount_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';

class DiscountDialog extends StatefulWidget {
  const DiscountDialog({super.key});

  @override
  State<DiscountDialog> createState() => _DiscountDialogState();
}

class _DiscountDialogState extends State<DiscountDialog> {
  @override
  void initState() {
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    super.initState();
  }

  int discountIdSelected = 0;

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
              alignment: Alignment.centerLeft,
              children: [
                const Text(
                  'Select discount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
            const SizedBox(height: 25),
            BlocBuilder<DiscountBloc, DiscountState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (discounts) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: discounts
                          .map(
                            (discount) => ListTile(
                              title: Text(
                                discount.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text('Potongan (${discount.value}%)'),
                              contentPadding: EdgeInsets.zero,
                              textColor: Colors.black,
                              trailing: Checkbox(
                                value: discount.id == discountIdSelected,
                                onChanged: (value) {
                                  setState(() {
                                    discountIdSelected = discount.id!;
                                    context.read<CheckoutBloc>().add(
                                          CheckoutEvent.addDiscount(
                                            discount,
                                          ),
                                        );
                                  });
                                },
                              ),
                              onTap: () {
                                // context.pop();
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
