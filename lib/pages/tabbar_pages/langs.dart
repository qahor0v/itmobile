import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/course_classes.dart';
import '../../screens/lessons_screens/main_screen.dart';
import '../../screens/lessons_screens/lessons.dart';

class Languages extends StatefulWidget {
  static const String id = 'langs';

  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
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
                              playListName: Lang.playListName[index],
                              playListId: Lang.playListId[index],
                              videoCount: Lang.videoCount[index],
                              title: Lang.names[index],
                            )),
                  );
                },
                child: MainScreen(
                  lessonCount: Lang.playListName[index].length,
                  videoCount: totalCount(Lang.videoCount[index]),
                  lessonName: Lang.names[index],
                  imgUrl: Lang.imageUrl[index],
                  navigator: null,
                ),
              );
            },
            childCount: Lang.imageUrl.length,
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
