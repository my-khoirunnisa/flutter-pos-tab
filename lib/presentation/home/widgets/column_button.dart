import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class ColumnButton extends StatelessWidget {
  final String label;
  final String nominal;
  final VoidCallback onPressed;

  const ColumnButton({
    super.key,
    required this.label,
    required this.nominal,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 80.0,
          width: 130.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primaryLight),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                nominal,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  // fontSize: 14,
                ),
              ),
            ],
          )),
    );
  }
}
