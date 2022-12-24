// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final myBox = Hive.box('listBox');

  // bool? isDark;

  bool changeColor() {
    return myBox.get('theme') ?? false;
  }

  ///----------------------------------------------------------

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
  }

  @override
  void initState() {
    getData();
    getBooksData();
    getCompData();
    changeColor();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      appBar: AppBar(
        title: const Text("Mening Akkauntim"),
        backgroundColor: ColorClass().cocoColor(),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            // height: 400,
            //width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorClass().cocoColor(),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  blurStyle: BlurStyle.normal,
                )
              ],
            ),
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 12,
            ),
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/images/icon.png",
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Salom ${myBox.get("name") == null ? "" : myBox.get('name')}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      //fontFamily: Fonts
                      fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          Text(
                            "Email:  ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: Fonts
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        myBox.get("email") == null
                            ? " Elektron Manzil"
                            : " ${myBox.get("email")}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            //fontFamily: Fonts
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                    child: Row(
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.computer,
                              color: Colors.white,
                            ),
                            Text(
                              " Soha: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  //fontFamily: Fonts
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          myBox.get("soha") == null
                              ? "Kiritilmadi"
                              : myBox.get('soha'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              //fontFamily: Fonts
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 8),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.video_collection,
                            color: Colors.white,
                          ),
                          Text(
                            " ${myBox.get(1) == null ? 0 : name.length} ta",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: Fonts
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.book,
                            color: Colors.white,
                          ),
                          Text(
                            " ${myBox.get(3) == null ? 0 : booksName.length} ta",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: Fonts
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.code_off_sharp,
                            color: Colors.white,
                          ),
                          Text(
                            " ${myBox.get(5) == null ? 0 : compName.length} ta",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                //fontFamily: Fonts
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          listTile(
              ColorClass().isDark()
                  ? "Kunduzgi rejimni yoqish"
                  : "Tunggi rejimni yoqish",
              ColorClass().isDark() ? Icons.sunny : Icons.nightlight_outlined,
              themeColor),
          Container(
            decoration: BoxDecoration(
              color: ColorClass().cocoColor(),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 3,
                  blurStyle: BlurStyle.normal,
                )
              ],
            ),
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ListTile(
              onTap: () async {
                await Share.share("https://t.me/Flutt_UZ");
              },
              tileColor: ColorClass().cocoColor(),
              leading: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              title:const Text(
                "Ilovani ulashish",
                style:  TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  //fontFamily: Fonts
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          listTile("Baholash", Icons.star_rate_rounded, rateUS),
          listTile("Biz haqimizda", Icons.info_outline, launchURL),
          listTile("Chiqish", Icons.exit_to_app_outlined, logOut),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> shareApp() async {}

  rateUS() {
    return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Play Marketga qo'yilgach ishlaydi!")));
  }

  listTile(String title, icon, onTap) {
    return Container(
      decoration: BoxDecoration(
        color: ColorClass().cocoColor(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 1,
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ListTile(
        onTap: onTap,
        tileColor: ColorClass().cocoColor(),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            //fontFamily: Fonts
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    myBox.clear();
    setState(
      () {
        FirebaseAuth.instance.signOut();
        myBox.clear();
      },
    );
  }

  void themeColor() {
    changeColor() ? myBox.put("theme", true) : myBox.put("theme", false);
    setState(() {
      bool status = !myBox.get('theme');
      myBox.put("theme", status);
    });
    //  print(isDark);
    // print(myBox.get('theme') is bool);
  }

  Future<void> launchURL() async {
    const url = 'https://t.me/fluttuz';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw '$url => Error!';
    }
  }
}
