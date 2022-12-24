import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../main.dart';

class YouTubeVid extends StatefulWidget {
  const YouTubeVid(
      {required this.id, required this.name, required this.index, Key? key})
      : super(key: key);
  final String id;
  final String name;
  final int index;

  @override
  State<YouTubeVid> createState() => _YouTubeVidState();
}

class _YouTubeVidState extends State<YouTubeVid> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: YoutubePlayerController(
          flags: const YoutubePlayerFlags(
            showLiveFullscreenButton: true,
          ),
          initialVideoId: widget.id,
        ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: ColorClass().mainColor(),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: ColorClass().cocoColor(),
                title: Text(
                  "${widget.index} - dars",
                ),
              ),
              SliverToBoxAdapter(
                child: player,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      color: ColorClass().blackWhite(),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
