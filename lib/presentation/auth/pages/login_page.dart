import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../home/pages/dashboard_page.dart';
import '../bloc/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // late final FocusNode focusNode = FocusNode()
  //   ..addListener(() {
  //     setState(() {});
  //   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(
                  "assets/images/login_man.png",
                  height: 600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                margin: const EdgeInsets.only(bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white.withOpacity(0.25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                            fontSize: 38.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 450,
                      child: CustomTextField(
                        controller: emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        // obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 35),
                    SizedBox(
                      width: 450,
                      child: CustomTextField(
                        controller: passwordController,
                        label: 'Password',
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 450,
                      child: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            orElse: () {},
                            success: (authResponseModel) {
                              AuthLocalDatasource()
                                  .saveAuthData(authResponseModel);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Login Success!',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.green,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardPage(),
                                ),
                              );
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
                                height: 65,
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                        LoginEvent.login(
                                            email: emailController.text,
                                            password: passwordController.text),
                                      );
                                },
                                label: 'Login Account',
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(
                  "assets/images/login_woman.png",
                  height: 600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
