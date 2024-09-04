import 'package:ayat/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';

import '../utils/quran_class.dart';
import '../widgets/aya_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.box});
  final Box<dynamic> box;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Aya> _searchResults = [];
  String _userInput = "test";
  final PageController _controllerAyati = PageController(viewportFraction: 0.80);
  final PageController _controllerSearch = PageController(viewportFraction: 0.80);
  final TextEditingController tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.box.get("myAyas") == null){
      widget.box.put("myAyas", []);
    }
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 85,
          title: _selectedIndex == 0
              ? Text(
                  "آياتي",
                  style: AppTextStyles.titleStyle,
                )
              : TextField(
                  onSubmitted: onSearch,
                  onTap: clean,
                  controller: tc,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "بحث عن آيه",
                    hintStyle: AppTextStyles.normalStyle,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10),
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
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.home,
                size: 28,
                color: AppColors.g700,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          }),
        ),
        drawer: const Drawer(
          backgroundColor: Colors.black38,
        ),
        backgroundColor: AppColors.background,
        bottomNavigationBar: GNav(
            selectedIndex: _selectedIndex,
            color: AppColors.g400,
            activeColor: AppColors.g700,
            tabActiveBorder: Border.all(color: Colors.white),
            tabBackgroundColor: AppColors.g100,
            tabBorderRadius: 25,
            curve: Curves.easeInCubic,
            padding: const EdgeInsets.all(15),
            tabMargin: const EdgeInsets.all(5),
            onTabChange: navBar,
            mainAxisAlignment: MainAxisAlignment.center,
            tabs: const [
              GButton(
                icon: Icons.book,
                text: "آياتي",
              ),
              GButton(icon: Icons.search, text: "بحث")
            ]),
        body: _selectedIndex == 0
            ? PageView.builder(
          itemCount: widget.box.get("myAyas").length,
          controller: _controllerAyati,
          itemBuilder: (context, index) {
            return ListenableBuilder(
              listenable: _controllerAyati,
              builder: (context, child) {
                return AyaCard(ayaNum: widget.box.get("myAyas")[index],
                  ayaRemoved: (){
                    var ayaNum = widget.box.get("myAyas")[index];
                      var array = widget.box.get("myAyas");
                      array.remove(ayaNum);
                      widget.box.put("myAyas",array);
                      debugPrint("$ayaNum removed");
                      setState(() {});
                    });
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
                        itemBuilder: (_, i) {
                          return ListenableBuilder(
                          listenable: _controllerSearch,
                          builder: (BuildContext context, Widget? child) {
                            return AyaCard(ayaNum: _searchResults[i].myId, searchMode:true,
                                ayaAdded: (){
                                var ayaNum = _searchResults[i].myId;
                                var array = widget.box.get("myAyas");
                                array.add(ayaNum);
                                widget.box.put("myAyas",array);
                                debugPrint("$ayaNum added");
                              },
                            );
                          },);
                        }),
                  )
                ],
              ));
  }

  void navBar(int index) {
    setState(() {
      _selectedIndex = index;
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
      // FocusManager.instance.primaryFocus?.unfocus();
      setState(() {});
    }
  }

  // void ayaRemoved(aya){
  //   var array = widget.box.get("myAyas");
  //   array.remove(aya.myId);
  //   widget.box.put("myAyas",array);
  //   debugPrint("${aya.myId} removed");
  //   setState(() {});
  // }
  // void ayaAdded(){
  //   var array = widget.box.get("myAyas");
  //   array.add(aya.myId);
  //   widget.box.put("myAyas",array);
  //   debugPrint("${aya.myId} added");
  // }

}
