import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/assets/assets.gen.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';
import 'package:flutter_pos_tab_custom/presentation/report/bloc/transaction_report/transaction_report_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/report/widgets/filter_tab_bar.dart';
import 'package:flutter_pos_tab_custom/presentation/report/widgets/monthly_line_chart.dart';
import 'package:flutter_pos_tab_custom/presentation/report/widgets/pie_chart.dart';
import 'package:flutter_pos_tab_custom/presentation/report/widgets/weekly_line_chart.dart';
import 'package:intl/intl.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/cashier_info.dart';
import '../../../core/constants/colors.dart';
import '../../home/widgets/column_button.dart';
import '../../home/widgets/row_calculate.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: BlocBuilder<TransactionReportBloc, TransactionReportState>(
        builder: (context, state) {
          final totalRevenue = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.fold(
                  0, (previousValue, element) => previousValue + element.total);
            },
          );

          final totalItems = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.fold(
                0,
                (previousValue, element) => previousValue + element.totalItem,
              );
            },
          );

          // subtotal sudah dipotong diskon
          final subTotal = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.fold(
                0,
                (previousValue, element) => previousValue + element.subTotal,
              );
            },
          );

          final discount = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.fold(
                0,
                (previousValue, element) => (previousValue +
                        (element.subTotal * (element.discount / 100)))
                    .toInt(),
              );
            },
          );

          final tax = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.fold(
                0,
                (previousValue, element) => previousValue + element.tax,
              );
            },
          );

          final dineIn = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.length;
            },
          );

          final cashLength = state.maybeMap(
            orElse: () => 0,
            loaded: (value) {
              return value.transactionReport.length;
            },
          );

          return state.maybeWhen(
            orElse: () {
              return Row(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Report & Summary',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const WeeklyLineChart(),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const MonthlyLineChart(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Report After Sales.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            FilterTabBar(
                              tabTitles: const [
                                'Today',
                                'Weekly',
                                'Monthly',
                              ],
                              report: true,
                              initialTabIndex: 0,
                              tabView: [
                                Row(
                                  children: [
                                    Flexible(
                                        child: Column(
                                      children: [
                                        _SpecificReportCard(
                                          title: 'Total Orders',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportOrders.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Items',
                                          nominal: '0',
                                          image: Assets.icons.reportItems.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Tax',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportTax.path,
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const PieChartSample2(cash: 0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: Column(
                                      children: [
                                        _SpecificReportCard(
                                          title: 'Total Orders',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportOrders.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Items',
                                          nominal: '0',
                                          image: Assets.icons.reportItems.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Tax',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportTax.path,
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const PieChartSample2(cash: 0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                        child: Column(
                                      children: [
                                        _SpecificReportCard(
                                          title: 'Total Orders',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportOrders.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Items',
                                          nominal: '0',
                                          image: Assets.icons.reportItems.path,
                                        ),
                                        const SizedBox(height: 12),
                                        _SpecificReportCard(
                                          title: 'Total Tax',
                                          nominal: 'Rp. 0',
                                          image: Assets.icons.reportTax.path,
                                        ),
                                      ],
                                    )),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const PieChartSample2(cash: 0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
                                'Transaction Report',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Text(
                              //   DateFormat('dd MMMM yyyy')
                              //       .format(DateTime.now()),
                              //   style: const TextStyle(
                              //     color: Colors.grey,
                              //   ),
                              // ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 20),
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(22.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RowCalculate(
                                        title: 'Sub Total',
                                        nominal: '0',
                                      ),
                                      SizedBox(height: 10),
                                      RowCalculate(
                                        title: 'Tax (11%)',
                                        nominal: '0',
                                      ),
                                      SizedBox(height: 10),
                                      RowCalculate(
                                        title: 'Service Charge (11%)',
                                        nominal: '0',
                                      ),
                                      SizedBox(height: 10),
                                      RowCalculate(
                                        title: 'Discount',
                                        nominal: '0',
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        child: Divider(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                      RowCalculate(
                                        title: 'Grand Total',
                                        nominal: '0',
                                        isBold: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ColumnButton(
                                    label: 'Dine in',
                                    nominal: '0',
                                    onPressed: () {},
                                  ),
                                  ColumnButton(
                                    label: 'Take away',
                                    nominal: '0',
                                    onPressed: () {},
                                  ),
                                  ColumnButton(
                                    label: 'Delivery',
                                    nominal: '0',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Button.filled(
                              //   height: 50,
                              //   borderRadius: 11,
                              //   onPressed: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //     builder: (context) => const PaymentPage(),
                              //     //   ),
                              //     // );
                              //   },
                              //   label: 'Download PDF',
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (transactionReport) {
              return Row(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Report & Summary',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const WeeklyLineChart(),
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Flexible(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const MonthlyLineChart(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Report After Sales.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 15),
                            FilterTabBar(
                              tabTitles: const [
                                'Today',
                                'Weekly',
                                'Monthly',
                              ],
                              report: true,
                              initialTabIndex: 0,
                              tabView: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          _SpecificReportCard(
                                            title: 'Total Revenue',
                                            nominal:
                                                totalRevenue.currencyFormatRp,
                                            image:
                                                Assets.icons.reportOrders.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Items',
                                            nominal: totalItems.toString(),
                                            image:
                                                Assets.icons.reportItems.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Tax',
                                            nominal: tax.currencyFormatRp,
                                            image: Assets.icons.reportTax.path,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child:
                                              PieChartSample2(cash: cashLength),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          _SpecificReportCard(
                                            title: 'Total Revenue',
                                            nominal:
                                                totalRevenue.currencyFormatRp,
                                            image:
                                                Assets.icons.reportOrders.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Items',
                                            nominal: totalItems.toString(),
                                            image:
                                                Assets.icons.reportItems.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Tax',
                                            nominal: tax.currencyFormatRp,
                                            image: Assets.icons.reportTax.path,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child:
                                              PieChartSample2(cash: cashLength),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          _SpecificReportCard(
                                            title: 'Total Revenue',
                                            nominal:
                                                totalRevenue.currencyFormatRp,
                                            image:
                                                Assets.icons.reportOrders.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Items',
                                            nominal: totalItems.toString(),
                                            image:
                                                Assets.icons.reportItems.path,
                                          ),
                                          const SizedBox(height: 12),
                                          _SpecificReportCard(
                                            title: 'Total Tax',
                                            nominal: tax.currencyFormatRp,
                                            image: Assets.icons.reportTax.path,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 300,
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child:
                                              PieChartSample2(cash: cashLength),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
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
                                'Transaction Report',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              // Text(
                              //   DateFormat('dd MMMM yyyy')
                              //       .format(DateTime.now()),
                              //   style: const TextStyle(
                              //     color: Colors.grey,
                              //   ),
                              // ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 30, bottom: 20),
                                decoration: BoxDecoration(
                                  color: AppColors.light,
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(22.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RowCalculate(
                                        title: 'Revenue',
                                        nominal: totalRevenue.currencyFormatRp,
                                      ),
                                      const SizedBox(height: 10),
                                      RowCalculate(
                                        title: 'Tax (11%)',
                                        nominal: tax.currencyFormatRp,
                                      ),
                                      const SizedBox(height: 10),
                                      const RowCalculate(
                                        title: 'Service Charge (0%)',
                                        nominal: '0',
                                      ),
                                      const SizedBox(height: 10),
                                      RowCalculate(
                                        title: 'Discount',
                                        nominal: discount.currencyFormatRp,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        child: Divider(
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                      RowCalculate(
                                        title: 'Net Income (-tax)',
                                        nominal: subTotal.currencyFormatRp,
                                        isBold: true,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ColumnButton(
                                    label: 'Dine in',
                                    nominal: dineIn.toString(),
                                    onPressed: () {},
                                  ),
                                  ColumnButton(
                                    label: 'Take away',
                                    nominal: '0',
                                    onPressed: () {},
                                  ),
                                  ColumnButton(
                                    label: 'Delivery',
                                    nominal: '0',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Button.filled(
                              //   height: 50,
                              //   borderRadius: 11,
                              //   onPressed: () {
                              //     // Navigator.push(
                              //     //   context,
                              //     //   MaterialPageRoute(
                              //     //     builder: (context) => const PaymentPage(),
                              //     //   ),
                              //     // );
                              //   },
                              //   label: 'Download PDF',
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _SpecificReportCard extends StatelessWidget {
  final String title;
  final String nominal;
  final String image;
  const _SpecificReportCard({
    required this.title,
    required this.nominal,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                color: AppColors.light, shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                image,
                width: 40,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              const SizedBox(height: 5),
              Text(
                nominal,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
