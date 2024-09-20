import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final Color color;
  final double height;
  final double fontSize;
  final String? prefixText;
  final TextAlign textAlign;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.color = Colors.white,
    this.height = 20,
    this.fontSize = 18,
    this.prefixText,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            Padding(
              padding: const EdgeInsets.only(left: 13),
              child: Text(
                label ?? '',
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 5),
            child: SizedBox(
              height: height,
              child: TextFormField(
                controller: controller,
                onChanged: onChanged,
                obscureText: obscureText,
                keyboardType: keyboardType,
                readOnly: readOnly,
                textAlign: textAlign,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  prefixText: prefixText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  labelStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
