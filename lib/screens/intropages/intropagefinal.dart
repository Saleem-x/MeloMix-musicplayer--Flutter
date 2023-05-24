import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../materials/material.dart';
import '../homescreen/homescreen.dart';
import '../splashscreen.dart';

class IntroPagefinal extends StatelessWidget {
  const IntroPagefinal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: sendory,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/loading_screen.jpg',
            fit: BoxFit.contain,
          ),
          Positioned(
            bottom: 100,
            left: size.width * 0.3,
            right: size.width * 0.3,
            child: TextButton(
                onPressed: () {
                  goTomain(context);
                },
                child: Text(
                  'Get Started...',
                  style: GoogleFonts.play(fontSize: 17, color: primary),
                )),
          )
        ],
      ),
    );
  }

  Future<void> goTomain(BuildContext context) async {
    final username = await SharedPreferences.getInstance();

    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(Save_Key, true);
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }
}
