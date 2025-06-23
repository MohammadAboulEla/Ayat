import 'package:ayat/utils/app_styles.dart';
import 'package:ayat/utils/settings.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    int numOfSavedAyas = SettingsBox.instance.get("myAyas", defaultValue: <dynamic>[]).length;
    return Drawer(
      backgroundColor: Colors.black38, // was black38
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(2),
              width: double.infinity,
              child: BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(2),
              width: double.infinity,
              child: Text(
                textDirection: TextDirection.rtl,
                " • آيات محفوظة: $numOfSavedAyas",
                style: AppTextStyles.normalStyle.copyWith(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
