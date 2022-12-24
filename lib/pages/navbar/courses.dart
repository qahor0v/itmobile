import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/pages/tabbar_pages/computer.dart';
import 'package:itmobile/pages/tabbar_pages/dasturlash.dart';
import 'package:itmobile/pages/tabbar_pages/dizayn.dart';
import 'package:itmobile/pages/tabbar_pages/langs.dart';
import 'package:itmobile/pages/tabbar_pages/others.dart';

class VideoCourses extends StatefulWidget {
  static const String id = 'videocourses';

  const VideoCourses({Key? key}) : super(key: key);

  @override
  State<VideoCourses> createState() => _VideoCoursesState();
}

class _VideoCoursesState extends State<VideoCourses> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorClass().cocoColor(),
          title: const Text(
            'Video Darslar',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                text: "Dasturlash",
              ),
              Tab(
                text: "Dizayn",
              ),
              Tab(
                text: 'Kompyuter',
              ),
              Tab(
                text: 'Chet Tili',
              ),
              Tab(
                text: 'Boshqalar',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Dasturlash(),
            Dizayn(),
            Computer(),
            Languages(),
            Others()
          ],
        ),
      ),
    );
  }
}
