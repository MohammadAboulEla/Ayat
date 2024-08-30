import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  void navBar(int index){
  setState(() {
    _selectedIndex = index;
  });}

  final List<Widget> w = [
    Container(color: Colors.orange),
    Container(color: Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: GNav(
      color: Colors.grey[400],
      activeColor: Colors.grey.shade700,
      tabActiveBorder: Border.all(color: Colors.white),
      tabBackgroundColor: Colors.grey.shade100,
      tabBorderRadius: 25,
      tabMargin: const EdgeInsets.all(5),
      onTabChange: navBar,
      mainAxisAlignment: MainAxisAlignment.center,
      tabs: const [
        GButton(icon: Icons.home, text: "t1",),
        GButton(icon: Icons.lock, text: "t2")
      ]),
      body: Center(
        child:_selectedIndex == 0 ? w[0]:w[1],)
    );
  }
}
