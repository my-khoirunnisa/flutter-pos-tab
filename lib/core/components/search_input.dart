import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final VoidCallback? onTap;
  final String hintText;

  const SearchInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.onTap,
    this.hintText = 'Search in here',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 2),
            blurRadius: 11,
            spreadRadius: 0,
          )
        ],
      ),
      child: TextFormField(
        onTap: onTap,
        readOnly: onTap != null,
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: Colors.black.withOpacity(0.40)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.40)),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
