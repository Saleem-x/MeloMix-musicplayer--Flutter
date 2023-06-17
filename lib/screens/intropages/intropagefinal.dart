import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../materials/material.dart';
import '../homescreen/homescreen.dart';
import '../splashscreen.dart';

class IntroPagefinal extends StatefulWidget {
  const IntroPagefinal({super.key});

  @override
  State<IntroPagefinal> createState() => _IntroPagefinalState();
}

class _IntroPagefinalState extends State<IntroPagefinal> {
  String result = "Let's slide!";
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
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
            left: 20,
            right: 20,
            child: /* SlideAction(
              innerColor: sendory,
              outerColor: primary,
              text: 'Swipe to Enter',
              textStyle: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              onSubmit: () {
                goTomain(context);
              },
            ), */
                SizedBox(
              width: 100,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  goTomain(context);
                },
                child: const Text('Start'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> goTomain(BuildContext context) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setBool(Save_Key, true);
    // ignore: use_build_context_synchronously
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return HomeScreen();
    // }));
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    ), (route) => false);
  }
}
