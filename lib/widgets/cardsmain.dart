import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:google_fonts/google_fonts.dart';
import '../materials/material.dart';

class CardsList extends StatelessWidget {
  final int idx;
  final IconData icon;
  final String ftitle;
  final String stitle;
  const CardsList(
      {super.key,
      required this.idx,
      required this.icon,
      required this.ftitle,
      required this.stitle});

  @override
  Widget build(BuildContext context) {
    double H;
    double W;
    if (idx == 1) {
      H = 130;
      W = 100;
    } else {
      H = 100;
      W = 130;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: primary,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 5,
              offset: const Offset(0, 3),
              inset: true,
            ),
          ],
        ),
        height: H,
        width: W,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ftitle,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.play(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(stitle,
                        style: GoogleFonts.play(
                          color: Colors.white,
                          fontSize: 15,
                        ))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
