import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/screens/recentlyplayed/recentlist.dart';
// import 'package:music_player/screens/homescreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../materials/material.dart';
import '../screens/homescreen/homescreen.dart';

miniplayer(BuildContext context, AssetsAudioPlayer player) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      builder: (context) {
        return Container(
          color: sendory,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              player.builderCurrent(
                builder: (context, playing) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 7,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30))),
                              ),
                              ListTile(
                                title: Text(
                                  player.getCurrentAudioTitle,
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  player.getCurrentAudioArtist,
                                  style: TextStyle(
                                    color: primary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: primary,
                                  child: ClipOval(
                                    child: QueryArtworkWidget(
                                      id: 0,
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Image.asset(
                                          'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                    ),
                                  ),
                                ),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PlayerBuilder.isPlaying(
                                          player: player,
                                          builder: (context, isPlaying) {
                                            return IconButton(
                                                onPressed: () async {
                                                  isPlaying =
                                                      isPlaying = !isPlaying;
                                                  await player.playOrPause();
                                                },
                                                icon: Icon(
                                                  isPlaying
                                                      ? FontAwesomeIcons
                                                          .circlePause
                                                      : FontAwesomeIcons
                                                          .circlePlay,
                                                  color: primary,
                                                  size: 30,
                                                ));
                                          }),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          FontAwesomeIcons.ellipsisVertical,
                                          color: primary,
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        );
      },
    );
  });
}

// ignore: camel_case_types
class mplayer extends StatelessWidget {
  const mplayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: sendory,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          player.builderCurrent(
            builder: (context, playing) {
              // ignore: unrelated_type_equality_checks
              if (player.isPlaying == true) {
                recentList.add(currentlyplaying!);
              }
              return Row(
                children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 7,
                            width: 20,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                          ),
                          ListTile(
                            title: Marquee(
                              blankSpace: 30,
                              startPadding: 0,
                              text: 'NO Songs Is Currently Playings',
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              player.getCurrentAudioArtist,
                              style: TextStyle(
                                color: primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: primary,
                              child: ClipOval(
                                child: QueryArtworkWidget(
                                  id: 0,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Image.asset(
                                      'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                                ),
                              ),
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              PlayerBuilder.isPlaying(
                                  player: player,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                        onPressed: () async {
                                          isPlaying = isPlaying = !isPlaying;
                                          await player.playOrPause();
                                        },
                                        icon: Icon(
                                          isPlaying
                                              ? FontAwesomeIcons.circlePause
                                              : FontAwesomeIcons.circlePlay,
                                          color: primary,
                                          size: 30,
                                        ));
                                  }),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.ellipsisVertical,
                                  color: primary,
                                ),
                              ),
                            ]),
                          )
                        ]),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class mplayernull extends StatelessWidget {
  const mplayernull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            color: sendory,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 15),
          title: Marquee(
            blankSpace: 30,
            startPadding: 0,
            text: 'NO Songs Is Currently Playings',
            style: TextStyle(
                color: primary, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: primary,
              child: ClipOval(
                child: QueryArtworkWidget(
                  id: 0,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: Image.asset(
                      'assets/images/Retro_cassette_tape_vector-removebg-preview (2).png'),
                ),
              ),
            ),
          ),
        ));
  }
}
