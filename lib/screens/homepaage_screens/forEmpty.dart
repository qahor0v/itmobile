import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/pages/navbar/books.dart';
import 'package:itmobile/pages/navbar/compliers.dart';
import 'package:itmobile/pages/navbar/courses.dart';
import 'package:itmobile/pages/tabbar_pages/langs.dart';


class HomeAppbar extends StatefulWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.36,
      width: double.infinity,
      child: PageView(
        children: [
          _items(
              "assets/images/IMG_20220715_215405_364_copy_1280x853.jpg",
              "BEPUL VA SIFATLI VIDEOKURSLAR",
              const VideoCourses(),
              'BOSHLASH'),
          _items("assets/images/IMG_20220715_215408_600_copy_1024x682.jpg",
              "TIL BILGAN - EL BILADI", const Languages(), "BOSHLASH"),
          _items(
              "assets/images/IMG_20220715_215412_404_copy_1280x839.jpg",
              "BARCHA ADABIYOTLAR HAM ILOVADA JAMLANDI",
              const BooksPage(),
              "BOSHLASH"),
          _items(
              "assets/images/IMG_20220715_215414_012_copy_1280x853.jpg",
              "KODLARNI ILOVA ICHIDA SINAB KO'RING",
              const Compliers(),
              "BOSHLASH")
        ],
      ),
    );
  }

  _items(url, text, navigator, title) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 0, top: 12, bottom: 8),
      height: MediaQuery.of(context).size.height * 0.36,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          colorFilter: const ColorFilter.mode(
            Colors.black45,
            BlendMode.xor,
          ),
          image: AssetImage(
            url,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  //textScaleFactor: 3,
                  textAlign: TextAlign.left, maxLines: null,
                ),
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(
                      left: 12, right: 12, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: ColorClass().cocoColor(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => navigator),
                  );
                },
              )
            ],
            // crossAxisAlignment: CrossAxisAlignment.end,
          )
        ],
      ),
    );
  }
}
