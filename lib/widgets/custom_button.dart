import 'package:ayat/utils/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, this.onPressed, required this.ayaNum});

  final int ayaNum;
  final void Function()? onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Future<bool> checkAya(int ayaNum) async {
    Box<dynamic> box = SettingsBox.instance;
    var array = await box.get("myAyas", defaultValue: <int>[]);
    return !array.contains(ayaNum);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkAya(widget.ayaNum),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return SizedBox(width: 0, height: 0); // placeholder
        bool isPlus = snapshot.data!;
        return IconButton(
          onPressed: widget.onPressed,
          icon: isPlus ? Icon(Icons.bookmark_add) : Icon(Icons.bookmark_remove),
        );
      },
    );
  }
}
