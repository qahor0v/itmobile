import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/screens/lessons_screens/lessons.dart';
import '../../models/course_classes.dart';
import '../../screens/lessons_screens/main_screen.dart';

class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
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
                child: MainScreen(
                  lessonCount: Others1.playListName[index].length,
                  videoCount: totalCount(Others1.videoCount[index]),
                  lessonName: Others1.names[index],
                  imgUrl: Others1.imageUrl[index],
                  navigator: null,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonPage(
                        playListName: Others1.playListName[index],
                        playListId: Others1.playListId[index],
                        videoCount: Others1.videoCount[index],
                        title: Others1.names[index],
                      ),
                    ),
                  );
                },
              );
            },
            childCount: Others1.imageUrl.length,
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
