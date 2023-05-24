import 'package:flutter/material.dart';

import '../../materials/material.dart';
import 'intropagefinal.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.asset(
              'assets/images/screen_3.png',
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
                  style: TextStyle(color: primary, fontSize: 17),
                )),
          ),
        ],
      ),
    );
  }
}
