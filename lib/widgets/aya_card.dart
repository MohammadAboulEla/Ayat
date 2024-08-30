import 'dart:collection';

import 'package:ayat/utils/app_colors.dart';
import 'package:ayat/utils/quran_class.dart';
import 'package:flutter/material.dart';

class AyaCard extends StatelessWidget {
  AyaCard({super.key, required this.ayaNum});
  final int ayaNum;
  final quran = Quran();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: screenWidth - 60,
            margin: const EdgeInsets.only(top: 80, left: 10,right: 10),
            child: Center(child: Text(quran.getAyaText(ayaNum),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              style: TextStyle(color: AppColors.g700,
                  height: 1.6,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "othman"),
                  textDirection: TextDirection.rtl,
            )),
          ),
          Container(
            width: screenWidth - 60,
            margin: const EdgeInsets.only(top: 80, left: 10,right: 10),
            child: Center(child: Text(quran.getAyaText(ayaNum),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              style: TextStyle(color: AppColors.g700,
                  height: 1.6,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "othman"),
              textDirection: TextDirection.rtl,
            )),
          ),
        ],
      ),
    );
  }
}
