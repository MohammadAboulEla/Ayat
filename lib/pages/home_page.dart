import 'package:ayat/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> w = [
    // Container(color: Colors.grey[400], margin: const EdgeInsets.all(5),),
    // Container(color: Colors.grey[600], margin: const EdgeInsets.all(5),),

    Container(),
    Container(
      child: Center(
        child: Text(
          "content 2",
          style: GoogleFonts.elMessiri(
              fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.g700),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: Text("آيات", style: GoogleFonts.elMessiri(fontSize: 26
          //     , fontWeight: FontWeight.bold, color: AppColors.g700),),
          title: SearchBar(
              hintText: "بحث عن آيه",
              hintStyle: WidgetStatePropertyAll(GoogleFonts.elMessiri(fontSize: 22,)),
              textStyle: WidgetStatePropertyAll(TextStyle()),
              leading: const Icon(Icons.search),
              backgroundColor: WidgetStatePropertyAll(AppColors.g400),
              elevation: const WidgetStatePropertyAll(0),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              )),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
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
        body: SafeArea(
          child: _selectedIndex == 0 ? w[0] : w[1],
        ));
  }
}
