// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:itmobile/pages/intro/my_name.dart';
import 'package:itmobile/pages/intro/sign_in.dart';
import 'package:itmobile/pages/intro/sign_up.dart';
import 'package:itmobile/pages/intro/splash_page.dart';
import 'package:itmobile/pages/mainpage.dart';
import 'package:itmobile/pages/navbar/books.dart';
import 'package:itmobile/pages/navbar/compliers.dart';
import 'package:itmobile/pages/navbar/courses.dart';
import 'package:itmobile/pages/tabbar_pages/langs.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var box = await Hive.openBox("listBox");
  runApp(const MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      routes: {
        Languages.id: (context) => const Languages(),
        VideoCourses.id: (context) => const VideoCourses(),
        BooksPage.id: (context) => const BooksPage(),
        Compliers.id: (context) => const Compliers(),
        SignIn.id: (context) => const SignIn(),
        // ignore: equal_keys_in_map
        SignUp.id: (context) => const SignUp(),
        // ignore: equal_keys_in_map
        MyNamePage.id: (context) => const MyNamePage(),
      },
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ignore: unrelated_type_equality_checks
          if (snapshot.connectionState == ConnectionState) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Xatolik! Qaytib urinib ko'ring!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const MainPage();
          } else {
            return const MyNamePage();
          }
          //return widget;
        },
      ),
    );
  }
}

///
///
///
// ignore: constant_identifier_names
const String API_KEY = "AIzaSyAFMr0mLSJtNcQ7RZqBBnORKeAIsYd-Rgw";

class ColorClass {
  bool isDark() {
    final myBox = Hive.box('listBox');
    bool dark = myBox.get('theme') ?? false;
    return dark;
  }

  mainColor() {
    return isDark() ? const Color(0xff13202f) : Colors.indigo.shade200;
  }

  cocoColor() {
    return isDark() ? Colors.black : Colors.indigo;
  }

  whiteBlack() {
    return isDark() ? Colors.black : Colors.white;
  }

  blackWhite() {
    return isDark() ? Colors.white : Colors.black;
  }
}
