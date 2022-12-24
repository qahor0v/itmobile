// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:itmobile/screens/bookspage_screens/pdf_view.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import '../models/constants.dart';

class BookDownloadScreen extends StatefulWidget {
  const BookDownloadScreen({
    super.key,
    required this.name,
    required this.url,
    required this.imgUrl,
    required this.pages,
    required this.size,
  });

  final String name;
  final String imgUrl;
  final String url;
  final double size;
  final int pages;

  @override
  State<BookDownloadScreen> createState() => _BookDownloadScreenState();
}

class _BookDownloadScreenState extends State<BookDownloadScreen> {
  final myBox = Hive.box('listBox');

  void onSaved(String widgetId, String widgetName) {
    String url = '*';
    String name = '*';
    if (myBox.get(3) != null) {
      url = myBox.get(3) + "*";
      name = myBox.get(4) + "*";
    }

    url = "$url$widgetId*";
    name = "$name$widgetName*";

    myBox.put(3, url);
    myBox.put(4, name);
    print("Data saved!");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 12, bottom: 4, right: 12),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: ColorClass().cocoColor(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.white, spreadRadius: 2, blurRadius: 5)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorClass().mainColor(),
                  border: Border.all(color: Colors.white, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  height: 500,
                  width: 500,
                  imageUrl: widget.imgUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Lottie.asset(
                    StringsConst.progressJson,
                  ),
                  errorWidget: (context, url, error) => Image.network(
                    StringsConst.errorImage,
                  ),
                  //  color: Colors.black12,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.all(4),
              //color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sahifalar : ${widget.pages}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Hajmi: ${widget.size} MB",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ViewPage(title: widget.name, url: widget.url),
                            ),
                          );
                        }
                      } on SocketException catch (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Internetga Ulanmagansiz!")));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.open_in_new,
                            color: ColorClass().cocoColor(),
                          ),
                          Text(
                            " O'qishni Boshlash",
                            style: TextStyle(
                                color: ColorClass().cocoColor(),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: ColorClass().cocoColor(),
                          ),
                          Text(
                            " Darsxonaga Qo'shish",
                            style: TextStyle(
                                color: ColorClass().cocoColor(),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      onSaved(widget.url, widget.name);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${widget.name} darsxonaga qo'shildi!")));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
