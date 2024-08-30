import 'package:ayat/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../widgets/aya_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final PageController _controller = PageController(viewportFraction: 0.8);

  void navBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> tabsWidgets = [
    PageView.builder(
      itemCount: 10,
      controller: _controller,
      itemBuilder: (context, index) {
        return ListenableBuilder(
          listenable: _controller,
          builder: (context, child) {
            double factor = 1;
            if (_controller.position.hasContentDimensions) {
              factor = 1 - (_controller.page! - index).abs();
            }

            return AyaCard(ayaNum: index+140);
          },
        );
      },
    ),
    Column(children: [
      _searchBar(),
    ],)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: Text("آياتي",style: AppTextStyles.titleStyle,),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // leadingWidth: 35,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.info,
                size: 35,
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
        body: _selectedIndex == 0 ? tabsWidgets[0] : tabsWidgets[1]);
  }
  Widget _searchBar(){
    return TextField(
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
          borderRadius: BorderRadius.all(Radius.circular(25)),
          borderSide: BorderSide.none,
        ),
      ),
      style: AppTextStyles.normalStyle,
    );
  }
}
