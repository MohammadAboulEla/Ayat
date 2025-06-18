import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
// import 'package:quran_reader/logic/setting_class.dart';

class Quran {
  static late final Quran _quran;
  late final List<dynamic> ayatData;
  late final List<dynamic> suraData;

  late Sura _currentSura;
  late Aya _currentAya;
  late Aya _currentVisAya;

  factory Quran(){
    return _quran;
  }

  //region PREPARE DATA
  /// Private constructor
  Quran._create();

  /// Public factory
  static Future<void> create() async {
    Quran copy = Quran._create();
    await copy.cashData();
    copy.loadData();
    _quran = copy;
  }


  Future<void> cashData() async {
    // final String myFile = await File('assets/jsons/ayat_data.json').readAsString();
    final String myFile =
    await rootBundle.loadString('assets/jsons/ayat_data.json');
    final readData = await jsonDecode(myFile);
    ayatData = readData;
    // final String myFile2 = await File('assets/jsons/suras_data.json').readAsString();
    final String myFile2 =
    await rootBundle.loadString('assets/jsons/suras_data.json');
    final readData2 = await jsonDecode(myFile2);
    suraData = readData2;
  }

  void loadData() {
    // _currentSura = getSuraById(Setting().lastSura);
    // _currentAya = getAyaByIdSimple(Setting().lastAya);
    // _currentVisAya = getAyaByIdSimple(Setting().lastVisAya);
  }
  //endregion

  void setCurrentSura(int suraId) {
    if (_currentSura.id!=suraId){
      _currentSura = getSuraById(suraId);
      setCurrentAya(_currentSura.ayat[0]);
      setCurrentVisAya(_currentSura.ayat[0]);

      /// save
      // Setting().saveLastSura(suraId);
      // Setting().saveLastAya(_currentSura.ayat[0].myId);
      // Setting().saveLastVisAya(_currentSura.ayat[0].myId);
      // Setting().saveLastPos(0.0);
    }
  } // MASTER
  void setNextSura() {
    if (_currentSura.id == 114) {
      setCurrentSura(1);
    } else {
      setCurrentSura(_currentSura.id + 1);
    }
  }
  void setPrevSura() {
    if (_currentSura.id == 1) {
      setCurrentSura(114);
    } else {
      setCurrentSura(_currentSura.id - 1);
    }
  }
  void setSuraByAyaId(int ayaId){
    for (dynamic e in ayatData){
      if(e['id'] == ayaId){
        setCurrentSura(e['mySura']);
        break;
      }
    }
  }
  void setCurrentAya(Aya aya) {
      _currentAya = aya;
      /// save
      // Setting().saveLastAya(aya.myId);
  }
  void setCurrentVisAya(Aya aya) {
    _currentVisAya = aya;
    /// save
    // Setting().saveLastVisAya(aya.myId);
  }
  Sura getSuraCard(int suraId) {
    return Sura.card(
        id: suraId,
        arabicName: suraData[suraId - 1]['name'],
        englishName: suraData[suraId - 1]['transliteration'],
        type: suraData[suraId - 1]['type']);
  }
  List<Sura> getSuraCardAll(int suraId) {
    List<Sura> temp = [];
    for (int i = 1; i < 115; i++) {
      temp.add(getSuraCard(i));
    }
    return temp;
  } //not used
  Aya getAyaMini(int ayaId) {
    Aya aya = Aya.simple(
      myId: ayaId,
      myText: ayatData[ayaId - 1]['text'],
    );
    return aya;
  }
  Aya getAyaByIdSimple(int ayaId) {
    Aya aya = Aya(
      myId: ayaId,
      myText: ayatData[ayaId - 1]['text'],
      myJuzText: ayatData[ayaId - 1]['juzText'],
      mySideText: ayatData[ayaId - 1]['sideText'],
    );
    return aya;
  }
  Aya getAyaByIdHeavy(int ayaId) {
    int suraNum = ayatData[ayaId - 1]['mySura'];
    String text = ayatData[ayaId - 1]['text'];
    String name =suraData[suraNum-1]["name"];
    String num = getAyaNumberFromText(text);
    Aya aya = Aya(
      myId: ayaId,
      myText: text,
      myJuzText: ayatData[ayaId - 1]['juzText'],
      mySideText: ayatData[ayaId - 1]['sideText'],
      mySuraName: name,
      myNumberInSuraArabic: num,
    );
    return aya;
  }
  List<Aya> searchForString(String searchFor){
    List<Aya> temp =[];
    for (dynamic e in ayatData){
      if (e["text_simple"].contains(searchFor)){
        String name = Quran().getSuraName(e["mySura"]);
        temp.add(Aya.search(
            myNumberInSuraArabic: getAyaNumberFromText(e["text"]),
            myId: e["id"],
            myText: e["text"],
            mySuraName: name)
        );
      }
    }
    return temp;
  }
  String getAyaNumberFromText(String text){
    String temp;
    temp = text.replaceAll(RegExp(r'[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FF]'),'');
    return temp.trim();
  }

  Sura getSuraById(int suraId) {
    List<dynamic> temp =[];
    for (dynamic aya in ayatData){
      if (aya['mySura'] == suraId) {temp.add(aya);}
      else if (aya['mySura'] == suraId+1) {log("done Break");break;}
    }
    return Sura(id: suraId, ayat: temp.map((x) => getAyaByIdSimple(x['id'])).toList());
  }
  int getAyaNumberInSura(Aya aya) {
    return _currentSura.ayat.indexOf(aya)+1;
  }
  int getAyaNumberInSuraByAyaId(int ayaId){
    Aya temp = Aya.simple(
      myId: ayaId,
      myText:"",
    );
    return getAyaNumberInSura(temp);
  }
  int getSuraLength(int suraId) {
    return suraData[suraId - 1]['total_verses'];
  } //not used
  String getCurrentSuraName() {
    return suraData[_currentSura.id - 1]['name'];
  }
  String getSuraName(int suraId) {
    return suraData[suraId - 1]['name'];
  }


  int getCurrentSuraLength() {
    return _currentSura.ayat.length;
  }
  String getAyaText(int ayaId) {
    return ayatData[ayaId - 1]['text'];
  }
  String getAyaTafseer(int ayaId) {
    return ayatData[ayaId - 1]['tafseer_muasr'];
  }
  String getAyaTextSimple(int ayaId) {
    return ayatData[ayaId - 1]['text_simple'];
  }

  Aya get currentAya => _currentAya;
  Sura get currentSura => _currentSura;
  Aya get currentVisAya => _currentVisAya;
}
// Sura getSuraByIdOld(int suraId) {
//   List<dynamic> temp =
//   ayatData.where((element) => element['mySura'] == suraId).toList();
//   List<Aya> ayat = temp.map((e) => getAyaById(e['id'])).toList();
//   return Sura(id: suraId, ayat: ayat);
// }
class Sura {
  Sura({required this.id, required this.ayat});

  Sura.card({
    required this.id,
    required this.arabicName,
    required this.englishName,
    required this.type,
    this.ayat = const [],
  });

  Sura.heavy(
      {required this.id,
        required this.versesCount,
        required this.arabicName,
        required this.englishName,
        required this.ayat,
        required this.type});

  final int id;
  final List<Aya> ayat;
  int? versesCount;
  String? type;
  String? arabicName;
  String? englishName;
  bool? hasBasmala;

  @override
  bool operator == (Object other) {
    if ((other is Sura)
        && id == other.id){
      return true;} else {return false;}
  }

  @override
  int get hashCode => id.hashCode;

}
class Aya {
  final int myId;
  final String myText;
  String? myJuzText;
  String? mySideText;
  String? myTafseer;
  int? mySuraNumber;
  int? myNumberInSura;
  String? myNumberInSuraArabic;
  String? myTextSimple;
  String? mySuraName;

  Aya({
    required this.myId,
    required this.myText,
    required this.myJuzText,
    required this.mySideText,
    this.mySuraName,
    this.myNumberInSura,
    this.myNumberInSuraArabic,
  });

  Aya.search({
    required this.myId,
    required this.myNumberInSuraArabic,
    required this.myText,
    required this.mySuraName,
  });

  Aya.simple({
    required this.myId,
    required this.myText,
  });

  Aya.heavy(
      {required this.myId,
        required this.myText,
        required this.myJuzText,
        required this.mySideText,
        required this.myTafseer,
        required this.mySuraNumber,
        required this.myNumberInSura,
        required this.myTextSimple,
        required this.mySuraName});

  @override
  bool operator == (Object other) {
    if ((other is Aya)
        && myId == other.myId){
      return true;} else {return false;}
  }

  @override
  int get hashCode => myId.hashCode;

}

