import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/data/datasource/product_local_datasource.dart';
import 'package:flutter_pos_tab_custom/presentation/setting/pages/manage_printer_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../bloc/sync_order/sync_order_bloc.dart';
import '../bloc/sync_product/sync_product_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Bluetooth Thermal Device',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          DateFormat('dd MMMM yyyy').format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 25),
                    // Text(
                    //   'Bluetooth Thermal Device',
                    //   style: TextStyle(
                    //     color: Colors.black,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    const SizedBox(height: 30),
                    const ManagePrinterPage()
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
                      // const CashierInfo(name: 'Khoirunnisa\''),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 10.0),
                      //   child: Divider(
                      //     color: AppColors.grey,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      const Text(
                        'Sync Data',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child:
                                BlocConsumer<SyncProductBloc, SyncProductState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  error: (message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          message,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red[700],
                                      ),
                                    );
                                  },
                                  loaded: (productResponseModel) {
                                    ProductLocalDatasource.instance
                                        .deleteAllProducts();
                                    ProductLocalDatasource.instance
                                        .insertProducts(
                                            productResponseModel.data!);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Sync product success!',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: AppColors.green,
                                      ),
                                    );
                                  },
                                );
                              },
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () {
                                    return _SyncCard(
                                      title: 'Sync Product',
                                      description: 'Click to sync product',
                                      icon: Assets.icons.syncProduct.path,
                                      onTap: () {
                                        context.read<SyncProductBloc>().add(
                                            const SyncProductEvent
                                                .syncProduct());
                                      },
                                    );
                                  },
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: BlocConsumer<SyncOrderBloc, SyncOrderState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  orElse: () {},
                                  loaded: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Sync order success!',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: AppColors.green,
                                      ),
                                    );
                                  },
                                  error: (message) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          message,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                    return _SyncCard(
                                      title: 'Sync Order',
                                      description: 'Click to sync order',
                                      icon: Assets.icons.syncOrder.path,
                                      onTap: () {
                                        context.read<SyncOrderBloc>().add(
                                            const SyncOrderEvent.syncOrder());
                                      },
                                    );
                                  },
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
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

class _SyncCard extends StatelessWidget {
  final String title;
  final String description;
  final String icon;
  final VoidCallback onTap;
  const _SyncCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.primaryLight),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              // padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.light,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 40,
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(description),
          ],
        ),
      ),
    );
  }
}
