import 'package:flutter/material.dart';
import 'package:music_player/screens/intropages/intropage1.dart';
import 'package:music_player/screens/intropages/intropage2.dart';
import 'package:music_player/screens/intropages/intropage4.dart';
import 'package:music_player/screens/intropages/intropagefinal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'intropages/intropage3.dart';

PageController controller = PageController();

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
              IntroPage4(),
              IntroPagefinal()
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.95),
              child: SmoothPageIndicator(
                controller: controller,
                count: 5,
                effect: const WormEffect(
                  dotHeight: 15,
                  dotWidth: 15,
                ),
              ))
        ],
      ),
    );
  }
}
