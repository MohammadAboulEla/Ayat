import 'package:ayat/utils/app_styles.dart';
import 'package:ayat/utils/quran_class.dart';
import 'package:flutter/material.dart';

class AyaCard extends StatelessWidget {
  AyaCard({super.key, required this.ayaNum, this.isSearch = false});
  final int ayaNum;
  final quran = Quran();
  final bool isSearch;


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
    return Container(
      decoration: BoxDecoration(
          color: AppColors.background, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(10),
      width: screenWidth - 60,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          isSearch? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("مفضلة",style: AppTextStyles.normalStyle,),
              IconButton(onPressed: (){},
                icon: const Icon(Icons.headphones),
              ),
              IconButton(onPressed: (){},
                icon: const Icon(Icons.bookmark_add),
              ),
              IconButton(onPressed: (){},
                icon: const Icon(Icons.favorite),
              ),
            ],
          ):const SizedBox(width: 0,),
          Center(
            child: Text(
          quran.getAyaText(ayaNum),
          textAlign: TextAlign.justify,
          overflow: TextOverflow.visible,
          style: AppTextStyles.ayaStyle,
          textDirection: TextDirection.rtl,
        )),
        ],
      ),
    );}

  Widget _containerTafseer(screenWidth) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.g400, borderRadius: BorderRadius.circular(15)),
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
    );
  }
}
