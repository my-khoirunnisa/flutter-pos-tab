import 'package:flutter/material.dart';

import '../../../core/components/search_input.dart';

class HomeTitle extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final String title;
  final String hintText;
  const HomeTitle(
      {super.key,
      required this.controller,
      this.onChanged,
      required this.title,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: SearchInput(
            controller: controller,
            onChanged: onChanged,
            hintText: hintText,
          ),
        ),
      ],
    );
  }
}
