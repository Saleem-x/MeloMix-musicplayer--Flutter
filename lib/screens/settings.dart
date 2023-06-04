import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/screens/homescreen/homescreen.dart';
import 'package:music_player/widgets/settingslist.dart';
import '../materials/material.dart';
import 'about/about .dart';
import 'package:share_plus/share_plus.dart';

import 'about/privacy.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Container(
                  height: 40,
                  width: 55,
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
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.chevronLeft,
                    color: Colors.white,
                  ),
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
                width: width * 0.7,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Settings',
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: primary),
              child: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: Container(
                        height: height * 0.08,
                        decoration: BoxDecoration(
                            color: sendory,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.circleHalfStroke,
                                color: primary,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Switch Theme',
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 120,
                              ),
                              Switch(
                                value: dark,
                                activeColor: primary,
                                onChanged: (value) {
                                  setState(() {
                                    dark = value;
                                    themeswitcher(!dark);
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return HomeScreen();
                                      },
                                    ), (route) => false);
                                  });
                                },
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const PrivacyPolicy();
                      },
                    ));
                  },
                  child: const SettingsList(
                      title: 'Privacy Policy',
                      icon: FontAwesomeIcons.userCheck),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const AboutScreen();
                      },
                    ));
                  },
                  child: const SettingsList(
                    title: 'About Us',
                    icon: FontAwesomeIcons.circleInfo,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Share.share(
                        'Checkout Melo Mix offline Music Player https://play.google.com/store/apps/details?id=in.brototype.melo_mix',
                        subject:
                            'Enjoy the Real Taste of Offline Music With Melo Mix ');
                  },
                  child: const SettingsList(
                    title: 'Share',
                    icon: FontAwesomeIcons.shareNodes,
                  ),
                )
              ]),
            ),
          )
        ],
      )),
    );
  }
}
