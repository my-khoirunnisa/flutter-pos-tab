import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/components/buttons.dart';
import 'package:flutter_pos_tab_custom/core/components/custom_text_field.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_pos_tab_custom/core/extentions/string_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/bank_tab_bar.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/order_menu_payment.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/row_calculate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/checkout/checkout_bloc.dart';
import '../dialogs/payment_confirm_dialog.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final totalPriceController = TextEditingController();
  // final products = [
  //   ProductModel(
  //       image: Assets.images.menu8.path,
  //       name: 'Mini Sandwitch',
  //       category: ProductCategory.other,
  //       price: 45000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu9.path,
  //       name: 'Snack Plate ',
  //       category: ProductCategory.other,
  //       price: 35000,
  //       stock: 10),
  // ];
  final amounts = [
    50000,
    100000,
    150000,
    200000,
    250000,
    300000,
    350000,
    400000,
  ];
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Confirmation.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Cashier Info.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(11.0)),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.icons.profile.path,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Khoirunnisa\'',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Cashier',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Sun, Sept 08, 2024',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '4:55 PM',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.bgPaymentCard,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 25, right: 25, bottom: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Item',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 35),
                                        child: Text(
                                          'Qty',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Price',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Divider(
                                    color: AppColors.divider,
                                  ),
                                ),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    return state.maybeWhen(
                                      orElse: () => const Center(
                                        child: Text('No items'),
                                      ),
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (items.isEmpty) {
                                          return const Center(
                                            child: Text('No Items'),
                                          );
                                        }
                                        return ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              OrderMenuPayment(
                                                  data: items[index]),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 0),
                                          itemCount: items.length,
                                        );
                                      },
                                    );
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Divider(
                                    color: AppColors.divider,
                                  ),
                                ),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final price = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (items.isEmpty) {
                                          return 0;
                                        }
                                        return items
                                            .map((e) =>
                                                e.product.price!
                                                    .toIntegerFromText *
                                                e.quantity)
                                            .reduce((value, element) =>
                                                value + element);
                                      },
                                    );
                                    return RowCalculate(
                                      title: 'Sub Total',
                                      nominal: price.currencyFormatRp,
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final tax = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (tax == 0) {
                                          return 0;
                                        }
                                        return tax;
                                      },
                                    );
                                    return RowCalculate(
                                      title: 'Tax',
                                      nominal: '$tax%',
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final serviceCharge = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (serviceCharge == 0) {
                                          return 0;
                                        }
                                        return serviceCharge;
                                      },
                                    );
                                    return RowCalculate(
                                      title: 'Service Charge',
                                      nominal: '$serviceCharge%',
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    final discount = state.maybeWhen(
                                      orElse: () => 0,
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (discount == null) {
                                          return 0;
                                        }
                                        return discount.value!
                                            .replaceAll('.00', '')
                                            .toIntegerFromText;
                                      },
                                    );
                                    return RowCalculate(
                                      title: 'Discount',
                                      nominal: '$discount%',
                                    );
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Divider(
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                  builder: (context, state) {
                                    int total;
                                    int taxNew;
                                    int discountNew;
                                    int serviceNew;
                                    int totalAmount = 0;
                                    state.maybeWhen(
                                      orElse: () {
                                        total = 0;
                                        taxNew = 0;
                                        discountNew = 0;
                                        serviceNew = 0;
                                        totalAmount = 0;
                                      },
                                      loaded: (items, discount, tax,
                                          serviceCharge) {
                                        if (items.isEmpty) {
                                          total = 0;
                                        } else {
                                          total = items
                                              .map((e) =>
                                                  e.product.price!
                                                      .toIntegerFromText *
                                                  e.quantity)
                                              .reduce((value, element) =>
                                                  value + element);
                                        }
                                        if (tax == 0) {
                                          taxNew = 0;
                                        } else {
                                          taxNew = total * tax ~/ 100;
                                        }
                                        if (serviceCharge == 0) {
                                          serviceNew = 0;
                                        } else {
                                          serviceNew =
                                              total * serviceCharge ~/ 100;
                                        }
                                        if (discount == null) {
                                          discountNew = 0;
                                        } else {
                                          discountNew = total *
                                              int.parse(
                                                discount.value!
                                                    .replaceAll('.00', ''),
                                              ) ~/
                                              100;
                                        }
                                        totalAmount = total +
                                            taxNew +
                                            serviceNew -
                                            discountNew;
                                      },
                                    );
                                    return RowCalculate(
                                      title: 'Total Amount',
                                      nominal:
                                          totalAmount.ceil().currencyFormatRp,
                                      isBold: true,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 0,
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 45),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                width: 38,
                                height: 38,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 15),
                              itemCount: 10,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 55),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BankTabBar(
                      tabTitles: const [
                        'Cash',
                        'Qris',
                        'Virtual Account',
                      ],
                      tabIcons: [
                        Assets.icons.paymentCash.path,
                        Assets.icons.paymentQris.path,
                        Assets.icons.paymentVa.path,
                      ],
                      initialTabIndex: 0,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 270,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.bgPaymentCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 70, left: 50, right: 50),
                        child: CustomTextField(
                          controller: totalPriceController,
                          showLabel: false,
                          color: AppColors.bgPaymentCard,
                          height: 80,
                          fontSize: 40.0,
                          prefixText: 'Rp. ',
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              // Format the text with currency
                              totalPriceController.value = TextEditingValue(
                                text: int.parse(totalPriceController.text)
                                    .currencyFormatRp
                                    .replaceAll('Rp. ', ''),
                                selection: TextSelection.collapsed(
                                    offset: int.parse(totalPriceController.text)
                                        .currencyFormatRp
                                        .length),
                              );
                            }
                          },
                          // obscureText: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 130,
                      child: GridView.count(
                        childAspectRatio: 2.9,
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(),
                        children: amounts.map((amount) {
                          return Button.outlined(
                            onPressed: () {
                              setState(() {
                                selectedValue = amount;
                                totalPriceController.text = selectedValue
                                    .currencyFormatRp
                                    .replaceAll('Rp. ', '');
                              });
                            },
                            borderRadius: 11,
                            textColor: Colors.black,
                            label: amount.currencyFormatRp,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Button.outlined(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            borderRadius: 11,
                            textColor: AppColors.primary,
                            label: 'Cancel',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: Button.filled(
                            borderRadius: 11,
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return PaymentConfirmDialog(
                                      totalPriceController:
                                          totalPriceController.text);
                                },
                              );
                            },
                            label: 'Order Now',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
