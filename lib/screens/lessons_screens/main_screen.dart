// ignore_for_file: depend_on_referenced_packages

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/constants.dart';
import 'package:lottie/lottie.dart';


class MainScreen extends StatefulWidget {
  const MainScreen(
      {super.key,
      required this.lessonCount,
      required this.videoCount,
      required this.lessonName,
      required this.imgUrl,
      required this.navigator});

  final int lessonCount;
  final int videoCount;
  final String lessonName;
  final String imgUrl;
  final dynamic navigator;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 8),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          color: ColorClass().cocoColor(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
            )
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1),
                color: ColorClass().mainColor(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.height * 0.23,
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Lottie.asset(
                    StringsConst.progressJson,
                  ),
                  errorWidget: (context, url, error) => Image.network(
                    StringsConst.errorImage,
                  ),
                  //  color: Colors.black12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    widget.lessonName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 8,
                      ),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 6, bottom: 6),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.ondemand_video_outlined,
                            color: ColorClass().cocoColor(),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.lessonCount}",
                                  style: TextStyle(
                                      color: ColorClass().cocoColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  " ta kurs",
                                  style: TextStyle(
                                      color: ColorClass().cocoColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 8, top: 8),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 6, bottom: 6),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.video_collection,
                            color: ColorClass().cocoColor(),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.videoCount}",
                                  style: TextStyle(
                                      color: ColorClass().cocoColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  " ta video",
                                  style: TextStyle(
                                      color: ColorClass().cocoColor(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
