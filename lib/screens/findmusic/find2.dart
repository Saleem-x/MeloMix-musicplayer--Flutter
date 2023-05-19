import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_acrcloud/flutter_acrcloud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../materials/material.dart';

class Find2 extends StatefulWidget {
  const Find2({super.key});

  @override
  State<Find2> createState() => _Find2State();
}

class _Find2State extends State<Find2> {
  ACRCloudResponseMusicItem? music;
  @override
  void initState() {
    ACRCloud.setUp(const ACRCloudConfig(
        'f7e680a066a887f0c15fc5121e5d237c',
        'zYbI3Yz9uc2sV0MHKE5XbgyoB4A2IZ7DmkapWwqJ',
        'identify-ap-southeast-1.acrcloud.com'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
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
                ],
              ),
              Builder(
                builder: (context) => AvatarGlow(
                  endRadius: 60,
                  child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        music = null;
                      });

                      final session = ACRCloud.startSession();

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: const Text('Listening...'),
                          content: StreamBuilder(
                            stream: session.volumeStream,
                            initialData: 0,
                            builder: (_, snapshot) =>
                                Text(snapshot.data.toString()),
                          ),
                          actions: [
                            TextButton(
                              onPressed: session.cancel,
                              child: const Text('Cancel'),
                            )
                          ],
                        ),
                      );

                      final result = await session.result;
                      Navigator.pop(context);

                      if (result == null) {
                        // Cancelled.
                        return;
                      } else if (result.metadata == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('No result.'),
                        ));
                        return;
                      }

                      setState(() {
                        music = result.metadata!.music.first;
                      });
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: primary,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
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
                        child: const Center(
                          child: Icon(
                            Icons.radar,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (music != null) ...[
                Container(
                  color: Colors.black,
                  height: 100,
                  width: 100,
                  child: Text('Track: ${music!.title}\n'),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
