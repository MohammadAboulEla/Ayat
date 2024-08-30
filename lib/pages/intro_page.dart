import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Expanded(child: Container(color: Colors.orange,)),
        const Expanded(child: Text("Welcome",)),
        ElevatedButton(onPressed: (){}, child: const Text("start")),
        const Expanded(child: SizedBox()),
      ],),

    );
  }
}
