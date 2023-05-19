import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../materials/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: sendory,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: primary,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                        inset: true,
                      ),
                    ],
                    color: primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  height: height * 0.05,
                  width: width * 0.8,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'About Us',
                      style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1.5,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                          inset: true,
                        ),
                      ],
                      color: primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 25, right: 10),
                      child: ListView(children: [
                        Text(
                          about,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        )
                      ]),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const about =
    '''MeloMix is a revolutionary offline music player designed to enhance your music listening experience. With our app, you can enjoy your favorite tunes anywhere, even without an internet connection. MeloMix combines the convenience of an offline music player with the power of internet connectivity to offer unique features such as fetching song lyrics and finding songs using audio recognition technology.

Key Features:

Offline Music Playback:
MeloMix allows you to create a personalized music library by importing your favorite songs directly into the app. Enjoy uninterrupted playback without the need for an internet connection, ensuring a seamless and immersive music experience.

Lyrics Fetching:
Say goodbye to searching for song lyrics on the internet. MeloMix harnesses the power of the internet to automatically fetch and display lyrics for the songs in your library. With just a few taps, you can sing along to your favorite tracks or delve deeper into the meaning behind the lyrics.

Audio-Based Song Recognition:
Discover new songs effortlessly with MeloMix's audio recognition feature. Simply hold your device up to any playing song, and the app will use its advanced audio recognition technology to identify the track. This feature is perfect for those moments when you hear a song you love but don't know its title or artist.

Smart Recommendations:
MeloMix leverages the internet connection to provide personalized recommendations based on your music preferences. Discover new artists, albums, and playlists curated just for you. Enjoy the thrill of exploring a vast musical landscape tailored to your unique taste.

User-Friendly Interface:
Our app offers a clean and intuitive user interface, ensuring a hassle-free music browsing experience. With MeloMix, you can easily navigate through your music library, search for songs, and access additional features effortlessly.

Customization Options:
Personalize your music playback experience with MeloMix's customization options. Customize the app's theme, layout, and audio settings to suit your preferences, creating a truly personalized music player that reflects your style.

Conclusion:
MeloMix is a feature-rich offline music player that brings together the joy of offline music playback with the convenience of internet connectivity. With its lyrics fetching capability and audio-based song recognition, MeloMix transforms your music listening experience, making it more engaging, informative, and enjoyable. Download MeloMix today and unlock a world of musical possibilities right at your fingertips.





''';
