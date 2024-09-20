import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_pos_tab_custom/data/datasource/discount_remote_datasource.dart';
import 'package:flutter_pos_tab_custom/data/datasource/order_remote_datasource.dart';
import 'package:flutter_pos_tab_custom/data/datasource/product_local_datasource.dart';
import 'package:flutter_pos_tab_custom/data/datasource/product_remote_datasource.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/bloc/delete_discount/delete_discount_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/bloc/update_discount/update_discount_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_pos_tab_custom/presentation/report/bloc/transaction_report/transaction_report_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:flutter_pos_tab_custom/presentation/setting/bloc/sync_product/sync_product_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/auth/bloc/logout/logout_bloc.dart';
import 'presentation/auth/pages/login_page.dart';
import 'presentation/discount/bloc/add_discount/add_discount_bloc.dart';
import 'presentation/discount/bloc/discount/discount_bloc.dart';
import 'presentation/home/bloc/bloc/order_bloc.dart';
import 'presentation/home/bloc/checkout/checkout_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SyncProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              LocalProductBloc(ProductLocalDatasource.instance),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => DiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => DeleteDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateDiscountBloc(DiscountRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              TransactionReportBloc(ProductLocalDatasource.instance),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(
                color: AppColors.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
              iconTheme: const IconThemeData(
                color: AppColors.primary,
              ),
            )),
        home: screenWidth < 600
            ? const Scaffold(
                body: Center(
                  child: Text(
                    'App Khusus Screen With 600 (Tablet Version) ganti resolusi anda.',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              )
            : FutureBuilder(
                future: AuthLocalDatasource().isAuthDataExists(),
                builder: (context, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const Scaffold(
                  //     body: Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   );
                  // }
                  if (snapshot.hasData) {
                    if (snapshot.data!) {
                      return const DashboardPage();
                    } else {
                      return const LoginPage();
                    }
                  }
                  return const Scaffold(
                    body: Center(
                      child: Text('Error'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
