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

  bool checkAya(ayaNum){
    Box<dynamic> box = SettingsBox.instance;
    var array = box.get("myAyas", defaultValue: <dynamic>[]);
    return !array.contains(ayaNum);
  }

  @override
  Widget build(BuildContext context) {
    bool isPlus = checkAya(widget.ayaNum);
    return IconButton(onPressed:(){
      setState(() {
        widget.onPressed?.call();
      });
    },
      icon: isPlus? Icon(Icons.bookmark_add):
      Icon(Icons.bookmark_remove),
    );
  }
}


