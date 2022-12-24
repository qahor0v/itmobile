import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../api_tools/playlist_screen.dart';
import '../../main.dart';

class LessonPage extends StatefulWidget {
  LessonPage(
      {required this.playListName,
      required this.playListId,
      required this.videoCount,
      required this.title});

  final List<String> playListId;
  final List<String> playListName;
  final List<int> videoCount;
  final String title;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final myBox = Hive.box('listBox');

  void onSaved(String widgetId, String widgetName) {
    String id = '*';
    String name = '*';
    if (myBox.get(1) != null) {
      id = myBox.get(1) + "*";
      name = myBox.get(2) + "*";
    }

    id = "$id$widgetId*";
    name = "$name$widgetName*";

    myBox.put(1, id);
    myBox.put(2, name);
    print("Data saved!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorClass().cocoColor(),
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 2,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 3.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 12, top: 12, right: 12),
                decoration: BoxDecoration(
                    color: ColorClass().cocoColor(),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 3,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () async {
                        try {
                          final result =
                              await InternetAddress.lookup('google.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonsList(
                                    id: widget.playListId[index],
                                    appBarTitle: widget.playListName[index]),
                              ),
                            );
                          }
                        } on SocketException catch (_) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content:  Text("Internetga Ulanmagansiz!")));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorClass().cocoColor(),
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.playListName[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.ondemand_video,
                              color: Colors.white,
                            ),
                            Text(
                              " ${widget.videoCount[index]} ta video",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            //
                            GestureDetector(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                  left: 4,
                                  right: 4,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: ColorClass().cocoColor(),
                                    ),
                                    Text(
                                      " Darsxonaga Qo'shish",
                                      style: TextStyle(
                                        color: ColorClass().cocoColor(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                onSaved(widget.playListId[index],
                                    widget.playListName[index]);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${widget.playListName[index]} darsxonaga qo'shildi!")));
                              },
                            ),
                            // Expanded(child: Container()),
                          ],
                        ),
                        Expanded(child: Container()),
                      ],
                    )
                  ],
                ),
              );
            },
            childCount: widget.playListName.length,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
          ),
        ),
      ]),
    );
  }
}
