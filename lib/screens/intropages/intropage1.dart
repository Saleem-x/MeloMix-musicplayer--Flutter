import 'package:flutter/material.dart';
import 'package:music_player/screens/intropages/intropagefinal.dart';

import '../../materials/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primary,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              'assets/images/screen_1.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const IntroPagefinal();
                    },
                  ));
                },
                child: Text(
                  'Skip',
                  style: TextStyle(color: sendory, fontSize: 17),
                )),
          ),
        ],
      ),
    );
  }
}
