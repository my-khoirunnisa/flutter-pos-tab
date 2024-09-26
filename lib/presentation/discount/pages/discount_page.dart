import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/components/buttons.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/bloc/add_discount/add_discount_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/bloc/discount/discount_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/dialogs/edit_discount_dialog.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/widgets/discount_card.dart';

import '../../../core/components/cashier_info.dart';
import '../../../core/components/custom_text_field.dart';
import '../../home/widgets/home_title.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<DiscountPage> createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  final discountNameController = TextEditingController();
  final discountDescriptionController = TextEditingController();
  final discountTypeController = TextEditingController();
  final discountNominalController = TextEditingController();
  final searchController = TextEditingController();

  // List<DiscountModel> searchResults = [];

  // final List<DiscountModel> products = [
  //   DiscountModel(
  //     name: 'Black Friday',
  //     code: 'D-001',
  //     discount: 5,
  //     category: ProductCategory.food,
  //     description: '',
  //   ),
  //   DiscountModel(
  //     name: 'Special Weekend',
  //     code: 'D-002',
  //     discount: 8,
  //     category: ProductCategory.snack,
  //     description: '',
  //   ),
  //   DiscountModel(
  //     name: 'Grand Opening',
  //     code: 'D-003',
  //     discount: 20,
  //     category: ProductCategory.drink,
  //     description: '',
  //   ),
  //   DiscountModel(
  //     name: 'New Member',
  //     code: 'D-004',
  //     discount: 10,
  //     category: ProductCategory.other,
  //     description: '',
  //   ),
  // ];

  @override
  void initState() {
    // searchResults = products;
    context.read<DiscountBloc>().add(const DiscountEvent.getDiscounts());
    super.initState();
  }

  @override
  void dispose() {
    discountNameController.text = '';
    discountDescriptionController.text = '';
    discountTypeController.text = '';
    discountNominalController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeTitle(
                      title: 'Discount List.',
                      hintText: 'Search discount in here ...',
                      controller: searchController,
                    ),
                    const SizedBox(height: 30),
                    // if (searchResults.isEmpty)
                    //   const Padding(
                    //     padding: EdgeInsets.only(top: 80.0),
                    //     child: _IsEmpty(),
                    //   )
                    // else
                    BlocBuilder<DiscountBloc, DiscountState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          loaded: (discounts) {
                            return SizedBox(
                              child: GridView.builder(
                                shrinkWrap: true,
                                itemCount: discounts.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 1.0,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 20.0,
                                ),
                                itemBuilder: (context, index) => DiscountCard(
                                  data: discounts[index],
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return EditDiscountDialog(
                                            data: discounts[index]);
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CashierInfo(name: 'Khoirunnisa\''),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Divider(
                          color: AppColors.grey,
                        ),
                      ),
                      const Text(
                        'New Discount',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        // width: 450,
                        margin: const EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.darkGrey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomTextField(
                          controller: discountNameController,
                          label: 'Discount Name',
                          // obscureText: true,
                        ),
                      ),
                      Container(
                        // width: 450,
                        margin: const EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColors.darkGrey),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomTextField(
                          controller: discountDescriptionController,
                          label: 'Description',
                          // obscureText: true,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              // width: 200,
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.darkGrey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: CustomTextField(
                                controller: discountTypeController,
                                label: 'Type',
                                // obscureText: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: Container(
                              // width: 200,
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.darkGrey),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: CustomTextField(
                                controller: discountNominalController,
                                label: 'Nominal',
                                suffixIcon: const Text(
                                  '%',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.grey),
                                ),
                                // obscureText: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AddDiscountBloc, AddDiscountState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            success: () {
                              context
                                  .read<DiscountBloc>()
                                  .add(const DiscountEvent.getDiscounts());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Discount Added!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.green,
                                ),
                              );
                              dispose();
                            },
                            error: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    message,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red[700],
                                ),
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return Button.filled(
                                height: 50,
                                borderRadius: 11,
                                onPressed: () {
                                  context.read<AddDiscountBloc>().add(
                                        AddDiscountEvent.addDiscount(
                                          name: discountNameController.text,
                                          description:
                                              discountDescriptionController
                                                  .text,
                                          value: int.parse(
                                              discountNominalController.text),
                                        ),
                                      );
                                },
                                label: 'Add New Discount',
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IsEmpty extends StatelessWidget {
  const _IsEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.noProduct.svg(),
          const SizedBox(height: 80.0),
          const Text(
            'You don\'t have any discount in here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
