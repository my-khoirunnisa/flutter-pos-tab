import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos_tab_custom/core/components/buttons.dart';
import 'package:flutter_pos_tab_custom/core/constants/colors.dart';
import 'package:flutter_pos_tab_custom/data/model/discount_response_model.dart';
import 'package:flutter_pos_tab_custom/presentation/discount/bloc/discount/discount_bloc.dart';

import '../../../core/components/custom_text_field.dart';
import '../bloc/delete_discount/delete_discount_bloc.dart';
import '../bloc/update_discount/update_discount_bloc.dart';

class EditDiscountDialog extends StatefulWidget {
  final Discount data;
  const EditDiscountDialog({super.key, required this.data});

  @override
  State<EditDiscountDialog> createState() => _EditDiscountDialogState();
}

class _EditDiscountDialogState extends State<EditDiscountDialog> {
  final discountNameController = TextEditingController();
  final discountDescriptionController = TextEditingController();
  final discountTypeController = TextEditingController();
  final discountNominalController = TextEditingController();

  @override
  void initState() {
    discountNameController.text = widget.data.name ?? '';
    discountDescriptionController.text = widget.data.description ?? '';
    discountTypeController.text = 'percentage';
    discountNominalController.text = widget.data.value!.replaceAll('.00', '');
    super.initState();
  }

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
                  'Edit Discount',
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
            Container(
              // width: 450,
              margin: const EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.darkGrey),
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomTextField(
                controller: discountNameController,
                label: 'Discount Name',
                // obscureText: true,
              ),
            ),
            Row(
              children: [
                Flexible(
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColors.darkGrey),
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
                      border: Border.all(width: 1, color: AppColors.darkGrey),
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
            const SizedBox(height: 40),
            Row(
              children: [
                Flexible(
                  child: BlocConsumer<DeleteDiscountBloc, DeleteDiscountState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Discount Deleted!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.green,
                            ),
                          );
                          context
                              .read<DiscountBloc>()
                              .add(const DiscountEvent.getDiscounts());
                          Navigator.pop(context);
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
                            onPressed: () {
                              context.read<DeleteDiscountBloc>().add(
                                  DeleteDiscountEvent.deleteDiscount(
                                      widget.data.id!));
                            },
                            label: 'Delete',
                            borderRadius: 11,
                            color: AppColors.darkGrey,
                            textColor: Colors.black,
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (message) => Center(
                          child: Text(message),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: BlocConsumer<UpdateDiscountBloc, UpdateDiscountState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Discount Updated!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: AppColors.green,
                            ),
                          );
                          context
                              .read<DiscountBloc>()
                              .add(const DiscountEvent.getDiscounts());
                          Navigator.pop(context);
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
                            onPressed: () async {
                              context
                                  .read<UpdateDiscountBloc>()
                                  .add(UpdateDiscountEvent.updateDiscount(
                                    name: discountNameController.text,
                                    description:
                                        discountDescriptionController.text,
                                    value: int.parse(
                                        discountNominalController.text),
                                    id: widget.data.id!,
                                  ));
                            },
                            label: 'Save',
                            borderRadius: 11,
                            color: AppColors.green,
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (message) => Center(
                          child: Text(message),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
