import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/components/cashier_info.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_pos_tab_custom/core/extentions/string_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/home/dialogs/discount_dialog.dart';
import 'package:flutter_pos_tab_custom/presentation/home/dialogs/service_dialog.dart';
import 'package:flutter_pos_tab_custom/presentation/home/pages/payment_page.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/custom_tab_bar.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/home_title.dart';
import 'package:flutter_pos_tab_custom/presentation/home/widgets/product_card.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../models/product_model.dart';
import '../widgets/column_button.dart';
import '../widgets/order_menu.dart';
import '../widgets/row_calculate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  List<ProductModel> searchResults = [];
  // final List<ProductModel> products = [
  //   ProductModel(
  //       image: Assets.images.menu1.path,
  //       name: 'Nasi Goreng',
  //       category: ProductCategory.food,
  //       price: 32000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu2.path,
  //       name: 'Chicken Burger',
  //       category: ProductCategory.food,
  //       price: 36000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu3.path,
  //       name: 'Chocolate Ice',
  //       category: ProductCategory.drink,
  //       price: 17000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu4.path,
  //       name: 'Matcha Ice',
  //       category: ProductCategory.drink,
  //       price: 21000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu5.path,
  //       name: 'Churros',
  //       category: ProductCategory.snack,
  //       price: 40000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu6.path,
  //       name: 'French Fries',
  //       category: ProductCategory.snack,
  //       price: 41000,
  //       stock: 10),
  //   ProductModel(
  //       image: Assets.images.menu7.path,
  //       name: 'Fruit Plate',
  //       category: ProductCategory.other,
  //       price: 44000,
  //       stock: 10),
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
  final List orderType = [
    ["Dine in", true],
    ["Take away", false],
    ["Delivery", false],
  ];

  @override
  void initState() {
    // searchResults = products;
    context
        .read<LocalProductBloc>()
        .add(const LocalProductEvent.getLocalProduct());
    super.initState();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    // if (index == 0) {
    //   searchResults = products;
    // } else {
    //   searchResults = products
    //       .where((e) => e.category.index.toString().contains(index.toString()))
    //       .toList();
    // }
    setState(() {});
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
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: HomeTitle(
                            title: 'Choose Category.',
                            hintText: 'Search menu in here ...',
                            controller: searchController),
                      ),
                      const SizedBox(height: 30),
                      CustomTabBar(
                        tabTitles: const [
                          'All',
                          'Food',
                          'Drink',
                          'Snack',
                          'Etc'
                        ],
                        tabIcons: [
                          Assets.icons.categoryAll.path,
                          Assets.icons.categoryFood.path,
                          Assets.icons.categoryDrink.path,
                          Assets.icons.categorySnack.path,
                          Assets.icons.categoryEtc.path,
                        ],
                        initialTabIndex: 0,
                        tabView: [
                          SizedBox(
                            child: BlocBuilder<LocalProductBloc,
                                LocalProductState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  loaded: (products) {
                                    if (products.isEmpty) {
                                      return const Center(child: _IsEmpty());
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1.02,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            child: BlocBuilder<LocalProductBloc,
                                LocalProductState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  loaded: (products) {
                                    if (products
                                        .where((element) =>
                                            element.category!.id == 1)
                                        .toList()
                                        .isEmpty) {
                                      return const Center(child: _IsEmpty());
                                    }
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id == 1)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id == 1)
                                            .toList()[index],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          BlocBuilder<LocalProductBloc, LocalProductState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loaded: (products) {
                                  if (products
                                      .where((element) =>
                                          element.category!.id == 2)
                                      .toList()
                                      .isEmpty) {
                                    return const Center(child: _IsEmpty());
                                  }
                                  return SizedBox(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id == 2)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id == 2)
                                            .toList()[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          BlocBuilder<LocalProductBloc, LocalProductState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loaded: (products) {
                                  if (products
                                      .where((element) =>
                                          element.category!.id == 3)
                                      .toList()
                                      .isEmpty) {
                                    return const Center(child: _IsEmpty());
                                  }
                                  return SizedBox(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: products
                                          .where((element) =>
                                              element.category!.id == 3)
                                          .toList()
                                          .length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.85,
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 30.0,
                                        mainAxisSpacing: 30.0,
                                      ),
                                      itemBuilder: (context, index) =>
                                          ProductCard(
                                        data: products
                                            .where((element) =>
                                                element.category!.id == 3)
                                            .toList()[index],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          BlocBuilder<LocalProductBloc, LocalProductState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                  orElse: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  loaded: (products) {
                                    if (products
                                        .where((element) =>
                                            element.category!.id == 4)
                                        .toList()
                                        .isEmpty) {
                                      return const Center(child: _IsEmpty());
                                    }
                                    return SizedBox(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: products
                                            .where((element) =>
                                                element.category!.id == 4)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 0.85,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 30.0,
                                        ),
                                        itemBuilder: (context, index) =>
                                            ProductCard(
                                          data: products
                                              .where((element) =>
                                                  element.category!.id == 4)
                                              .toList()[index],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
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
                          Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppColors.grey,
                                borderRadius: BorderRadius.circular(11)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      orderType[0][1] = true;
                                      orderType[1][1] = false;
                                      orderType[2][1] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: orderType[0][1]
                                          ? AppColors.green
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(11.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        orderType[0][0],
                                        style: TextStyle(
                                          color: orderType[0][1]
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: orderType[0][1]
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      orderType[0][1] = false;
                                      orderType[1][1] = true;
                                      orderType[2][1] = false;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: orderType[1][1]
                                          ? AppColors.green
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(11.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        orderType[1][0],
                                        style: TextStyle(
                                          color: orderType[1][1]
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: orderType[1][1]
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      orderType[0][1] = false;
                                      orderType[1][1] = false;
                                      orderType[2][1] = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    decoration: BoxDecoration(
                                      color: orderType[2][1]
                                          ? AppColors.green
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(11.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        orderType[2][0],
                                        style: TextStyle(
                                          color: orderType[2][1]
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: orderType[2][1]
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // const SizedBox(
                          //   height: 200,
                          //   child: Center(
                          //     child: Text(
                          //       'Empty, please add product first',
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 10),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const Center(
                                  child: Text('No items'),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                loaded: (items, discount, tax, serviceCharge) {
                                  if (items.isEmpty) {
                                    return const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 30),
                                        child: Text('No Items'),
                                      ),
                                    );
                                  }
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        OrderMenu(data: items[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: items.length,
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
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
                                        nominal: totalAmount.currencyFormatRp,
                                        isBold: true,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ColumnButton(
                                label: 'Tax',
                                nominal: '11%',
                                onPressed: () {},
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final serviceCharge = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded:
                                        (items, discount, tax, serviceCharge) {
                                      if (serviceCharge == 0) {
                                        return 0;
                                      }
                                      return serviceCharge;
                                    },
                                  );
                                  return ColumnButton(
                                    label: 'Service',
                                    nominal: '$serviceCharge%',
                                    onPressed: () => showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) =>
                                          const ServiceDialog(),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded:
                                        (items, discount, tax, serviceCharge) {
                                      if (discount == null) {
                                        return 0;
                                      }
                                      return discount.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    },
                                  );
                                  return ColumnButton(
                                    label: 'Discount',
                                    nominal: '$discount%',
                                    onPressed: () => showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) =>
                                          const DiscountDialog(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Button.filled(
                            height: 50,
                            borderRadius: 11,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentPage(),
                                ),
                              );
                            },
                            label: 'Go to Payment',
                          ),
                        ],
                      ),
                    ),
                  ],
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
          const SizedBox(height: 50.0),
          Assets.icons.noProduct.svg(),
          const SizedBox(height: 30.0),
          const Text(
            'You don\'t have any products in this category',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
