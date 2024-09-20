import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/pages/login_page.dart';

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

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
              'Logout? :(',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'You want to logout?',
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
                    label: 'No',
                    borderRadius: 11,
                  ),
                ),
                const SizedBox(width: 15.0),
                BlocConsumer<LogoutBloc, LogoutState>(
                  listener: (context, state) {
                    state.maybeMap(
                      orElse: () {},
                      error: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            value.message,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red[700],
                        ));
                      },
                      success: (value) {
                        AuthLocalDatasource().removeAuthData();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Logout Success',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: AppColors.green,
                        ));
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      },
                    );
                  },
                  builder: (context, state) {
                    return Flexible(
                      child: Button.filled(
                        onPressed: () async {
                          context
                              .read<LogoutBloc>()
                              .add(const LogoutEvent.logout());
                        },
                        label: 'Yes please',
                        borderRadius: 11,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
