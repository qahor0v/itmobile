// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/books_classes.dart';
import 'package:itmobile/screens/books_screens.dart';
import 'package:path_provider/path_provider.dart';

class BooksPage extends StatefulWidget {
  static const String id = 'BooksPage';

  const BooksPage({Key? key}) : super(key: key);

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  double? progress;
  String status = "Yuklab Olish";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      appBar: AppBar(
        backgroundColor: ColorClass().cocoColor(),
        title: const Text("Elektron Kitoblar"),
        centerTitle: true,
      ),
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
              childAspectRatio: 2.20,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return BookDownloadScreen(
                  name: BooksInfo.name[index],
                  url: BooksInfo.url[index],
                  imgUrl: BooksInfo.imgUrl[index],
                  pages: BooksInfo.pages[index],
                  size: BooksInfo.size[index],
                );
              },
              childCount: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }

  void downPDF(String url) async {
    setState(() {
      progress = null;
    });

    final request = Request("GET", Uri.parse(url));

    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    setState(() {
      progress = 0.000001;
      status = "Yuklanmoqda...";
    });

    List<int> bytes = [];
    final file = await _getFile("book.pdf");

    response.stream.listen(
      (List<int> newBytes) {
        bytes.addAll(newBytes);
        final downloadedLength = bytes.length;
        setState(() {
          progress = downloadedLength.toDouble() / (contentLength ?? 1);
          status = "${((progress ?? 0) * 100).toStringAsFixed(2)}%";
        });
        print(progress);
      },
      onDone: () async {
        setState(() {
          progress = 1;
          status = "Yuklangan!";
        });
        await file.writeAsBytes(bytes);
      },
      onError: (e) {
        debugPrint(e);
      },
      cancelOnError: true,
    );
  }

  Future _getFile(String filename) async {
    final dir = await getTemporaryDirectory();
    return File('${dir.path}/$filename');
  }
}
