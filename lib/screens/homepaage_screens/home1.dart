import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/constants.dart';

class Home1 extends StatefulWidget {
  Home1({
    required this.names,
    required this.imageUrl,
    required this.navigators,
    required this.nameMain,
    required this.nav,
  });

  final List<String> imageUrl;
  final List<String> names;
  final List navigators;
  final String nameMain;
  final dynamic nav;

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      //  color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.nameMain}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Barchasi",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.28,
            //  color: Colors.black26,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrl.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                  EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.height * 0.23,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.white,
                            spreadRadius: 3,
                            blurRadius: 5)
                      ]),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height * 0.26,
                          width: MediaQuery.of(context).size.height * 0.23,
                          imageUrl: widget.imageUrl[index],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //    height: MediaQuery.of(context).size.height * 0.24,
                            width: MediaQuery.of(context).size.height * 0.23,
                            padding:
                            EdgeInsets.only(left: 4, right: 4, bottom: 4),
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              widget.names[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
