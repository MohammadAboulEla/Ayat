import 'package:ayat/utils/app_styles.dart';
import 'package:ayat/utils/global_functions.dart';
import 'package:ayat/utils/settings.dart';
import 'package:ayat/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';

import '../utils/quran_class.dart';
import '../widgets/aya_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavIndex = 0;
  List<Aya> _searchResults = [];
  String _userInput = "test";
  final PageController _controllerAyati = PageController(viewportFraction: 1.0);
  final PageController _controllerSearch = PageController(viewportFraction: 1.0);
  final TextEditingController tc = TextEditingController();
  final Box<dynamic> box = SettingsBox.instance;

  @override
  Widget build(BuildContext context) {
    debugPrint("HomePage build called");
    // set nav bar color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: AppColors.background),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        title: _selectedNavIndex == 0
            ? Text("آياتي", style: AppTextStyles.titleStyle)
            : TextField(
                onSubmitted: onSearch,
                textInputAction: TextInputAction.search,
                controller: tc,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "بحث عن آيه",
                  hintStyle: AppTextStyles.normalStyle,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        onSearch(tc.text);
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        tc.text = "";
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.g400,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: AppTextStyles.normalStyle,
              ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leadingWidth: 60,
        leading: _selectedNavIndex == 0
            ? Builder(
                builder: (context) {
                  // We use a Builder to get the context of the Scaffold
                  return IconButton(
                    padding: EdgeInsets.only(left: 0),
                    icon: Icon(Icons.home, size: 28, color: AppColors.g700),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : BackButton(
                onPressed: () {
                  setState(() {
                    _selectedNavIndex = 0;
                    clean();
                  });
                },
              ),
        // actions: [CustomInfo(a: _controllerAyati.page?.round() ?? 0, b: box.get("myAyas").length)],
      ),
      drawer: CustomDrawer(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: GNav(
        selectedIndex: _selectedNavIndex,
        color: AppColors.g400,
        activeColor: AppColors.g700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: AppColors.g100,
        tabBorderRadius: 25,
        curve: Curves.easeInCubic,
        padding: const EdgeInsets.all(8),
        tabMargin: const EdgeInsets.only(top: 10),
        onTabChange: navBar,
        mainAxisAlignment: MainAxisAlignment.center,
        tabs: const [
          GButton(icon: Icons.book, text: "آياتي"),
          GButton(icon: Icons.search, text: "بحث"),
        ],
      ),
      body: _selectedNavIndex == 0
          ? PageView.builder(
              onPageChanged: (i) {
                debugPrint("page changed to $i");
              },
              itemCount: box.get("myAyas").length,
              controller: _controllerAyati,
              itemBuilder: (context, index) {
                return ListenableBuilder(
                  listenable: _controllerAyati,
                  builder: (context, child) {
                    return AyaCard(
                      ayaNum: box.get("myAyas")[index],
                      ayaToggled: () {
                        ayaRemoved(index);
                      },
                    );
                  },
                );
              },
            )
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controllerSearch,
                    scrollDirection: Axis.horizontal,
                    itemCount: _searchResults.length,
                    itemBuilder: (_, index) {
                      return ListenableBuilder(
                        listenable: _controllerSearch,
                        builder: (BuildContext context, Widget? child) {
                          return AyaCard(
                            ayaNum: _searchResults[index].myId,
                            nextAya: () {
                              replaceWithNextAya(index);
                            },
                            prevAya: () {
                              replaceWithPrevAya(index);
                            },
                            searchMode: true,
                            ayaToggled: () {
                              ayaToggled(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  void navBar(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  void clean() {
    tc.clear();
    _userInput = "";
    _searchResults = [];
    setState(() {});
  }

  void onSearch(val) {
    _userInput = val;
    if (_userInput != "") {
      _searchResults = Quran().searchForString(_userInput);
      setState(() {});
    }
  }

  void replaceWithNextAya(currentAyaNum) {
    final int nextAyaNum = _searchResults[currentAyaNum].myId + 1;
    final Aya nextAya = Quran().getAyaByIdHeavy(nextAyaNum);
    setState(() {
      _searchResults[currentAyaNum] = nextAya;
    });
    debugPrint("next is $nextAyaNum");
  }

  void replaceWithPrevAya(currentAyaNum) {
    final int nextAyaNum = _searchResults[currentAyaNum].myId - 1;
    final Aya nextAya = Quran().getAyaByIdHeavy(nextAyaNum);
    setState(() {
      _searchResults[currentAyaNum] = nextAya;
    });
    debugPrint("next is $nextAyaNum");
  }

  void ayaRemoved(index) {
    var array = box.get("myAyas", defaultValue: <int>[]);
    var ayaNum = box.get("myAyas")[index];
    if (!array.contains(ayaNum)) {
      debugPrint("ayaNum is null, cannot remove");
      return;
    }
    setState(() {
      array.remove(ayaNum);
      box.put("myAyas", array);
      const msg = "تم الحذف";
      showToast(context, msg);
    });
  }

  void ayaToggled(int index) {
    var ayaNum = _searchResults[index].myId;
    var array = box.get("myAyas", defaultValue: <int>[]);
    if (!array.contains(ayaNum)) {
      setState(() {
        array.add(ayaNum);
        box.put("myAyas", array);
        debugPrint("$ayaNum added");
        const msg = "تمت الإضافة";
        showToast(context, msg);
      });
    } else {
      setState(() {
        array.remove(ayaNum);
        box.put("myAyas", array);
        const msg = "تم الحذف";
        showToast(context, msg);
      });
    }
  }
}
