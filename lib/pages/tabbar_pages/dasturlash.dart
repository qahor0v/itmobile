import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/course_classes.dart';
import 'package:itmobile/screens/lessons_screens/lessons.dart';
import 'package:itmobile/screens/lessons_screens/main_screen.dart';
class Dasturlash extends StatefulWidget {
  const Dasturlash({Key? key}) : super(key: key);

  @override
  State<Dasturlash> createState() => _DasturlashState();
}

class _DasturlashState extends State<Dasturlash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            childAspectRatio: 2.50,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LessonPage(
                              playListName: Programming.playListName[index],
                              playListId: Programming.playListId[index],
                              videoCount: Programming.videoCount[index],
                          title: Programming.names[index],
                            )),
                    // List<String> playListName, List<String> playListId, List<int> videoCount
                  );
                },
                child: MainScreen(
                  lessonCount: Programming.playListName[index].length,
                  videoCount: totalCount(Programming.videoCount[index]),
                  lessonName: Programming.names[index],
                  imgUrl: Programming.imageUrl[index],
                  navigator: null,
                ),
              );
            },
            childCount: Programming.imageUrl.length,
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

  totalCount(List<int> list) {
    int total = 0;

    for (int i in list) {
      total += i;
    }
    return total;
  }
}
