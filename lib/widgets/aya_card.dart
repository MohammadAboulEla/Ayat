import 'package:ayat/utils/app_styles.dart';
import 'package:ayat/utils/quran_class.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/global_functions.dart';

class AyaCard extends StatelessWidget {
  AyaCard({super.key, required this.ayaNum, this.searchMode = false, this.ayaRemoved, this.ayaAdded,});
  final int ayaNum;
  final quran = Quran();
  final bool searchMode;
  final void Function()? ayaRemoved;
  final void Function()? ayaAdded;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [_containerAya(screenWidth), _containerTafseer(screenWidth)],
      ),
    );
  }

  Widget _containerAya(screenWidth) {
    Aya aya = quran.getAyaByIdHeavy(ayaNum);
    String suraAndNum = "${aya.mySuraName}-${extractLastNumber(aya.myText)}";
    String suraName = "${aya.mySuraName}";
    return Container(
      padding:const EdgeInsets.only(bottom: 10, top: 0) ,
      decoration: BoxDecoration(
          color: AppColors.background, borderRadius: BorderRadius.circular(15)),
      width: screenWidth - 60,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
      child: Column(
        children: [
          searchMode? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(onPressed: (){},
              //   icon: const Icon(Icons.headphones),
              // ),
              // IconButton(onPressed: (){},
              //   icon: const Icon(Icons.favorite),
              // ),
              IconButton(onPressed: ayaAdded,
                icon: const Icon(Icons.bookmark_add),
              ),
              // IconButton(onPressed: (){},
              //   icon: const Icon(Icons.chrome_reader_mode_rounded),
              // ),
            ],
          ):Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: ayaRemoved,
                icon: const Icon(Icons.bookmark_remove),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.visible,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${aya.myText}",
                  style: AppTextStyles.ayaStyle, // Specific style for this span
                ),
                TextSpan(
                  text: "  ($suraName)",
                  style: AppTextStyles.tafseerStyle, // Different style for this span
                ),

              ],
            ),
          ),
        ],
      ),
    );}

  Widget _containerTafseer(screenWidth) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.g400, borderRadius: BorderRadius.circular(15)),
      width: screenWidth - 60,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.g700, borderRadius: BorderRadius.circular(15) ),
          ),
          Center(
              child: Text(
            quran.getAyaTafseer(ayaNum),
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            style: AppTextStyles.tafseerStyle,
            textDirection: TextDirection.rtl,
          )),
        ],
      ),
    );
  }
}
