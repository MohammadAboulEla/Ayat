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
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.g200,
                borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(10),
            width: screenWidth - 60,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Center(
                child: Text(
              quran.getAyaText(ayaNum),
              textAlign: TextAlign.justify,
              overflow: TextOverflow.visible,
              style: AppTextStyles.ayaStyle,
              textDirection: TextDirection.rtl,
            )),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.g400,
                borderRadius: BorderRadius.circular(15)),
            width: screenWidth - 60,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Center(
                child: Text(
              quran.getAyaTafseer(ayaNum),
              textAlign: TextAlign.start,
              overflow: TextOverflow.visible,
              style: AppTextStyles.tafseerStyle,
              textDirection: TextDirection.rtl,
            )),
          ),
        ],
      ),
    );
  }
}
