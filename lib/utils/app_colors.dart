import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors{
  // static const Color white = Colors.white;
  static final Color background = Colors.grey[300]!;
  static final Color g100 = Colors.grey[100]!;
  static final Color g200 = Colors.grey[200]!;
  static final Color g400 = Colors.grey[400]!;
  static final Color g700 = Colors.grey[700]!;
  static final Color g800 = Colors.grey[800]!;
}
class AppTextStyles{
  static final TextStyle ayaStyle =  TextStyle(color: AppColors.g800,
      height: 1.6,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: "othman");
  static final TextStyle tafseerStyle = TextStyle(color: AppColors.g800,
      height: 1.6,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.rubik().fontFamily);
}