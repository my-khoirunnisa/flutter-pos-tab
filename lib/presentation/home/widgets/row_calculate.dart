import 'package:flutter/material.dart';
import 'package:flutter_pos_tab_custom/core/extentions/int_ext.dart';

class RowCalculate extends StatelessWidget {
  final String title;
  final String nominal;
  final bool isBold;
  const RowCalculate({
    super.key,
    required this.title,
    required this.nominal,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isBold ? const TextStyle(fontWeight: FontWeight.w600) : null,
        ),
        Text(
          nominal,
          style: isBold ? const TextStyle(fontWeight: FontWeight.w600) : null,
        )
      ],
    );
  }
}
