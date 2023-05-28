import 'package:flutter/material.dart';

import '../../materials/material.dart';
import 'intropagefinal.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset(
              'assets/images/screen_4.png',
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
