// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmobile/api_tools/api_services.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/constants.dart';
import 'package:itmobile/utilites/youtube_player.dart';
import 'package:lottie/lottie.dart';
import 'video_model.dart';

class LessonsList extends StatefulWidget {
  const LessonsList({super.key, required this.id, required this.appBarTitle});

  final String id;
  final String appBarTitle;

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  List<Video> _videos = [];

  @override
  void initState() {
    _initPlayList();
    super.initState();
  }

  _initPlayList() async {
    List<Video> playlistVideo = (await APIService.instance
        .fetchVideosFromPlaylist(playlistId: widget.id));
    List<Video> allVideos = _videos..addAll(playlistVideo);

    setState(() {
      _videos = allVideos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: ColorClass().cocoColor(),
          title: Text(widget.appBarTitle),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        _videos.isEmpty
            ? SliverToBoxAdapter(
                child: Lottie.asset(
                  StringsConst.progressJson,
                ),
              )
            : SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500.0,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 2.50,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => YouTubeVid(
                              id: _videos[index].id,
                              name: _videos[index].title,
                              index: index + 1,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        decoration: BoxDecoration(
                            color: ColorClass().cocoColor(),
                            borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                            blurRadius: 2
                          )
                        ]

                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: 500,
                                      width: 500,
                                      imageUrl: _videos[index].thumbnailUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Lottie.asset(
                                        StringsConst.progressJson,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.network(
                                        StringsConst.errorImage,
                                      ),
                                      //  color: Colors.black12,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _videos[index].title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${(index + 1).toString()} - dars",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _videos.length,
                ),
              ),
      const  SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
          ),
        ),
      ],
    ));
  }
}
