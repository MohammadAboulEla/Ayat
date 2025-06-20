import 'package:ayat/pages/home_page.dart';
import 'package:ayat/pages/intro_page.dart';
import 'package:ayat/utils/quran_class.dart';
import 'package:ayat/utils/settings.dart';
import 'package:flutter/material.dart';

Future initServices() async {
  await SettingsBox.create();
  await Quran.create();
}

void main() async {
  await initServices();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayat',
      home: HomePage(),
      routes: {
        '/intro': (context) => const IntroPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
