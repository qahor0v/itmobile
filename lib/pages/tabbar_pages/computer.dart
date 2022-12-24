import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/course_classes.dart';
import '../../screens/lessons_screens/main_screen.dart';
import '../../screens/lessons_screens/lessons.dart';

class Computer extends StatefulWidget {
  const Computer({Key? key}) : super(key: key);

  @override
  State<Computer> createState() => _ComputerState();
}

class _ComputerState extends State<Computer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(
        slivers: [
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
                    lessonCount: Computer1.playListName[index].length,
                    videoCount: totalCount(Computer1.videoCount[index]),
                    lessonName: Computer1.names[index],
                    imgUrl: Computer1.imageUrl[index],
                    navigator: null,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonPage(
                          playListName: Computer1.playListName[index],
                          playListId: Computer1.playListId[index],
                          videoCount: Computer1.videoCount[index],
                          title: Computer1.names[index],
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: Computer1.imageUrl.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
            ),
          ),
        ],
      ),
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
