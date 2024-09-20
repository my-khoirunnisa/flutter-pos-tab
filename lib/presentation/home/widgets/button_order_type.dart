// import 'package:flutter/material.dart';
// import '../../../core/constants/colors.dart';

// class ButtonOrderType extends StatefulWidget {
//   final String orderType;
//   final bool isSelected;
//   final void onTap;
//   const ButtonOrderType({super.key, 
//     required this.orderType,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   State<ButtonOrderType> createState() => _ButtonOrderTypeState();
// }

// class _ButtonOrderTypeState extends State<ButtonOrderType> {
//   bool? _isSelected;
//   @override
//   void initState() {
//     _isSelected = widget.isSelected;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           is
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//         decoration: BoxDecoration(
//           color: widget.isSelected ? AppColors.green : Colors.transparent,
//           borderRadius: BorderRadius.circular(11.0),
//         ),
//         child: Center(
//           child: Text(
//             widget.orderType,
//             style: TextStyle(
//               color: widget.isSelected ? Colors.white : Colors.black,
//               fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }