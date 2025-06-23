import 'package:ayat/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomInfo extends StatefulWidget {
  const CustomInfo({super.key, required this.a, required this.b});

  final int a; // Number of saved ayas
  final int b; // Total number of ayas
  @override
  State<CustomInfo> createState() => _CustomInfoState();
}

class _CustomInfoState extends State<CustomInfo> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "(${widget.a} / ${widget.b})", // Display the number of saved ayas
      style: AppTextStyles.tafseerStyle, // Different style for this span
    );
  }
}
