import 'package:ayat/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../widgets/aya_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
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
    ListView(
      scrollDirection: Axis.horizontal,
      children: [
        AyaCard(ayaNum: 15),
        AyaCard(ayaNum: 155),
        AyaCard(ayaNum: 200),
        AyaCard(ayaNum: 1550),
        AyaCard(ayaNum: 100),
        AyaCard(ayaNum: 150),
        AyaCard(ayaNum: 777),
      ],
    ),
    CarouselView(
        itemExtent: 300,
        padding: EdgeInsets.all(20),
        backgroundColor: AppColors.g400,
        elevation: 3,
        itemSnapping: true,
        scrollDirection: Axis.horizontal,
        children: [
          AyaCard(ayaNum: 15),
          AyaCard(ayaNum: 155),
          AyaCard(ayaNum: 200),
          AyaCard(ayaNum: 1550),
          AyaCard(ayaNum: 100),
          AyaCard(ayaNum: 150),
          AyaCard(ayaNum: 777),
        ]),
    Center(
      child: Text(
        "content 2",
        style: GoogleFonts.elMessiri(
            fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.g700),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: TextField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: "بحث عن آيه ",
              hintStyle: GoogleFonts.elMessiri(
                  fontSize: 18,
                  color: AppColors.g700,
                  fontWeight: FontWeight.bold),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  size: 35,
                ),
              ),
              filled: true,
              fillColor: AppColors.g400,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.elMessiri(fontSize: 22),
          ),
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
                icon: Icons.home,
                text: "t1",
              ),
              GButton(icon: Icons.lock, text: "t2")
            ]),
        body: _selectedIndex == 0 ? tabsWidgets[0] : tabsWidgets[1]);
  }
}
