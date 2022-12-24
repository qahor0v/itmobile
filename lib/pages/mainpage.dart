// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/pages/navbar/account.dart';
import 'package:itmobile/pages/navbar/compliers.dart';
import 'package:itmobile/pages/navbar/courses.dart';
import 'package:itmobile/pages/navbar/my_page.dart';
import 'navbar/books.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );
  final PageController _pageController = PageController();
  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = ColorClass().cocoColor();
  Color unselectedColor = Colors.blueGrey;

  Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: AnimatedContainer(
        color: containerColor ?? const Color(0xFFFDE1D7),
        duration: const Duration(seconds: 1),
        child: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              _selectedItemPosition = page;
            });
          },
          children: const <Widget>[
            MyPage(),
            VideoCourses(),
            BooksPage(),
            Compliers(),
            AccountPage(),
          ],
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        // height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor: snakeShape == SnakeShape.indicator
            ? ColorClass().cocoColor()
            : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: _selectedItemPosition,
        onTap: (value) {
          // onTap Bottom icon
          setState(() => _selectedItemPosition = value);
          _pageController.jumpToPage(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.computer), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_collection), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.code_off_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        // backgroundColor: Colors.blueGrey,
        //shadowColor: Colors.black,
      ),
    );
  }
}
