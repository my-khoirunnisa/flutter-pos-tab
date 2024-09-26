import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';

class ServiceDialog extends StatefulWidget {
  const ServiceDialog({super.key});

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  final listService = [0];
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
              // fit: StackFit.,
              alignment: Alignment.centerLeft,
              children: [
                const Text(
                  'Service charge',
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
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (items, discount, tax, serviceCharge) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: listService
                          .map(
                            (listService) => ListTile(
                              title: const Text(
                                'Service Charge',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text('($listService%)'),
                              contentPadding: EdgeInsets.zero,
                              textColor: Colors.black,
                              trailing: Checkbox(
                                value: serviceCharge == listService,
                                onChanged: (value) {
                                  setState(() {
                                    serviceCharge = listService;
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
