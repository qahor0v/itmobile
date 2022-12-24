// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/screens/bookspage_screens/pdf_view.dart';
import 'package:itmobile/screens/homepaage_screens/forEmpty.dart';
import 'package:itmobile/utilites/webcall.dart';
import '../../api_tools/playlist_screen.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final myBox = Hive.box('listBox');

  /// Lessonlarni chaqirish uchun funksiya va listlar
  List name = [];
  List id = [];

  void getData() {
    id = myBox.get(1).toString().split('*');
    name = myBox.get(2).toString().split('*');
    for (int i = 0; i < id.length; i++) {
      if (id[i] == "" || id[i] == null) {
        id.removeAt(i);
      }
    }
    for (int i = 0; i < name.length; i++) {
      if (name[i] == "" || name[i] == null) {
        name.removeAt(i);
      }
    }
    //id.removeAt(0);
    // name.removeAt(0);
  }

  /// Books-larni chaqirish uchun funksiya va listlar
  List booksName = [];
  List booksId = [];

  void getBooksData() {
    booksId = myBox.get(3).toString().split('*');
    booksName = myBox.get(4).toString().split('*');
    for (int i = 0; i < booksId.length; i++) {
      if (booksId[i] == "" || booksId[i] == null) {
        booksId.removeAt(i);
      }
    }
    for (int i = 0; i < booksName.length; i++) {
      if (booksName[i] == "" || booksName[i] == null) {
        booksName.removeAt(i);
      }
    }
    //id.removeAt(0);
    // name.removeAt(0);
  }

  /// Komplierlarni chaqirish uchun funksiya va list
  List compName = [];
  List compId = [];

  void getCompData() {
    compId = myBox.get(5).toString().split('*');
    compName = myBox.get(6).toString().split('*');
    for (int i = 0; i < compId.length; i++) {
      if (compId[i] == "" || compId[i] == null) {
        compId.removeAt(i);
      }
    }
    for (int i = 0; i < compName.length; i++) {
      if (compName[i] == "" || compName[i] == null) {
        compName.removeAt(i);
      }
    }
    //id.removeAt(0);
    // name.removeAt(0);
  }

  @override
  void initState() {
    getData();
    getBooksData();
    getCompData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.computer),
        centerTitle: true,
        title: const Text(
          "Mening Darsxonam",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        backgroundColor: ColorClass().cocoColor(),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Darsxona tozalandi!"),
                ),
              );
              myBox.delete(1);
              myBox.delete(2);
              myBox.delete(3);
              myBox.delete(4);
              myBox.delete(5);
              myBox.delete(6);
              setState(() {
                myBox.delete(1);
                myBox.delete(2);
                myBox.delete(3);
                myBox.delete(4);
                myBox.delete(5);
                myBox.delete(6);
              });
            },
            icon: const Icon(Icons.delete_sweep_outlined),
          )
        ],
      ),
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(
        slivers: [
          check() ? forEmpty() : sizedBox(),
          myBox.get(1) == null ? sizedBox() : textInfo("Videokurslaringiz"),
          myBox.get(1) == null ? sizedBox() : sliverLessons(),
          myBox.get(1) == null ? sizedBox() : divider(),
          myBox.get(3) == null ? sizedBox() : textInfo("Kitoblaringiz"),
          myBox.get(3) == null ? sizedBox() : sliverBooks(),
          myBox.get(3) == null ? sizedBox() : divider(),
          myBox.get(5) == null ? sizedBox() : textInfo("Editorlaringiz"),
          myBox.get(5) == null ? sizedBox() : sliverComp(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }

  divider() {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 12),
        child: Divider(
          height: 2,
          thickness: 1,
          color: ColorClass().blackWhite(),
        ),
      ),
    );
  }

  forEmpty() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const HomeAppbar(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Darsxona Bo'sh  ",
                  style: TextStyle(
                      color: ColorClass().blackWhite(),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Icon(
                  Icons.do_not_disturb_alt,
                  color: ColorClass().blackWhite(),
                  size: 28,
                )
              ],
            )),
          )
        ],
      ),
    );
  }

  sliverLessons() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.20,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,

                  //  offset: Offset(-1, 0)
                )
              ],
              color: ColorClass().cocoColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonsList(
                              id: id[index],
                              appBarTitle: name[index],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.slow_motion_video,
                            color: ColorClass().cocoColor(),
                          ),
                          Text(
                            " Davom Etish",
                            style: TextStyle(
                                color: ColorClass().cocoColor(),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        childCount: name.length,
      ),
    );
  }

  sliverBooks() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.20,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,

                  //  offset: Offset(-1, 0)
                )
              ],
              color: ColorClass().cocoColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  booksName[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewPage(
                              title: booksName[index],
                              url: booksId[index],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bookmark_border,
                            color: ColorClass().cocoColor(),
                          ),
                          Text(
                            " Davom Etish",
                            style: TextStyle(
                                color: ColorClass().cocoColor(),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        childCount: booksName.length,
      ),
    );
  }

  sliverComp() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.20,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
                color: ColorClass().cocoColor(),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,

                    //  offset: Offset(-1, 0)
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  compName[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WebCall(
                              url: compId[index],
                              title: compName[index],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        //  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.open_in_new_outlined,
                            color: ColorClass().cocoColor(),
                          ),
                          Text(
                            " O'tish",
                            style: TextStyle(
                              color: ColorClass().cocoColor(),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        childCount: compName.length,
      ),
    );
  }

  sizedBox() {
    return const SliverToBoxAdapter(
      child: SizedBox(),
    );
  }

  bool check() {
    if (myBox.get(1) == null && myBox.get(3) == null && myBox.get(5) == null) {
      return true;
    } else {
      return false;
    }
  }

  textInfo(String text) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
      child: Text(
        "Sizning $text",
        style: TextStyle(
            color: ColorClass().blackWhite(),
            fontWeight: FontWeight.bold,
            fontSize: 26),
      ),
    ));
  }
}
/*

  onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonsList(id: 'id', appBarTitle: 'appBarTitle')
                ),
              );
            },
* */
