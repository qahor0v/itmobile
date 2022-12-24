// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:itmobile/models/compilers_classes.dart';
import '../../utilites/webcall.dart';
import 'package:hive/hive.dart';
class Compliers extends StatefulWidget {
  static const String id = 'Compliers';

  const Compliers({Key? key}) : super(key: key);

  @override
  State<Compliers> createState() => _CompliersState();
}

class _CompliersState extends State<Compliers> {
  void onSaved(String widgetId, String widgetName) {
    String id = '*';
    String name = '*';
    if (myBox.get(5) != null) {
      id = myBox.get(5) + "*";
      name = myBox.get(6) + "*";
    }

    id = "$id$widgetId*";
    name = "$name$widgetName*";

    myBox.put(5, id);
    myBox.put(6, name);
    print("Data saved!");
  }

  final myBox = Hive.box('listBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorClass().cocoColor(),
            title: const Text("Kod Editorlari"),
            centerTitle: true,
          ),
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
              childAspectRatio: 3.60,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebCall(
                              url: CompilersInfo.url[index],
                              title: CompilersInfo.title[index],
                            ),
                          ),
                        );
                      }
                    } on SocketException catch (_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Internetga Ulanmagansiz!")));
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 8,
                    ),
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorClass().cocoColor(),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          CompilersInfo.title[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            // Expanded(child: Container()),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 12,
                                ),
                                padding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                  left: 6,
                                  right: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.open_in_new_outlined,
                                      color: ColorClass().cocoColor(),
                                    ),
                                    Text(
                                      " Ochish",
                                      style: TextStyle(
                                        color: ColorClass().cocoColor(),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 12,
                                  ),
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                    left: 6,
                                    right: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  onSaved(
                                    CompilersInfo.url[index],
                                    CompilersInfo.title[index],
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${CompilersInfo.title[index]} darsxonaga qo'shildi!",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Expanded(child: Container()),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: CompilersInfo.url.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
