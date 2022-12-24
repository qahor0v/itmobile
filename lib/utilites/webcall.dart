// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:itmobile/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebCall extends StatefulWidget {
  static const String id = 'web';
  final String url;
  final String title;

  WebCall({required this.url, required this.title});

  @override
  State<WebCall> createState() => _WebCallState();
}

class _WebCallState extends State<WebCall> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  double progres = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorClass().mainColor(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorClass().cocoColor(),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 3,
            value: progres,
            color: ColorClass().cocoColor(),
            backgroundColor: Colors.white,
          ),
          Expanded(
            child: WebView(
              initialUrl:
                  widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
              onProgress: (progres) => setState(
                () {
                  this.progres = progres / 100;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
