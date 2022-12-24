import 'package:flutter/material.dart';
import '../../api_tools/playlist_screen.dart';
import '../../main.dart';

class LessonPageMain extends StatefulWidget {
  const LessonPageMain(
      {required this.playListName,
      required this.playListId,
      required this.videoCount});

  final List<String> playListId;
  final List<String> playListName;
  final List<int> videoCount;

  @override
  State<LessonPageMain> createState() => _LessonPageMainState();
}

class _LessonPageMainState extends State<LessonPageMain> {
  onDel() {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorClass().cocoColor(),
        title: Text('Dars nomi'),
        centerTitle: true,
      ),
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 12,
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 2.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
                decoration: BoxDecoration(
                    color: ColorClass().cocoColor(),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white, spreadRadius: 2, blurRadius: 5)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonsList(
                                id: widget.playListId[index],
                                appBarTitle: widget.playListName[index]),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorClass().cocoColor(),
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.playListName[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
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
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(top: 8, bottom: 12),
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 12,
                              right: 12,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Icon(
                                  Icons.delete,
                                  color: ColorClass().cocoColor(),
                                ),
                                Text(
                                  " Darsxonadan O'chirish",
                                  style: TextStyle(
                                    color: ColorClass().cocoColor(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
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
