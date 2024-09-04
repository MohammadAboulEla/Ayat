import 'package:ayat/pages/home_page.dart';
import 'package:ayat/pages/intro_page.dart';
import 'package:ayat/utils/quran_class.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future initServices () async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Quran.create();
  //TODO: Make a button to toggle this
  WakelockPlus.enable();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  Box<dynamic> box = await Hive.openBox('settings');
  runApp(MyApp(box: box,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.box});
  final Box<dynamic> box;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(box: box,),
      routes: {
        '/intro': (context) => const IntroPage(),
        '/home': (context) => HomePage(box: box),
      },
    );
  }
}

