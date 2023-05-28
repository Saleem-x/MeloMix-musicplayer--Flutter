import 'package:flutter/material.dart';
import '../materials/material.dart';

class SettingsList extends StatelessWidget {
  final String title;
  final IconData icon;
  const SettingsList({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Container(
          height: height * 0.08,
          decoration: BoxDecoration(
              color: sendory, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: primary,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: primary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 120,
                ),
              ],
            ),
          )),
    );
  }
}
