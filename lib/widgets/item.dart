// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hmm/env.dart';
import 'package:hmm/themes/light_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ItemWidget extends StatefulWidget {
  final String? code;
  final String? hardware;
  final String? uptime;
  final String? mtbf;
  final String? mttr;
  final String? date;
  const ItemWidget(
      {Key? key,
      this.code,
      this.hardware,
      this.uptime,
      this.mtbf,
      this.mttr,
      this.date})
      : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  String url = Environment.resultPage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Color(0xffF1F1F5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode Maintenance",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(widget.code.toString(),
                      style: TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Kode Hardware",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(widget.hardware.toString(),
                      style: TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    "MTBF ${widget.mtbf}",
                    style: TextStyle(
                        color: LightColor.lightblack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "MTTR ${widget.mttr}",
                    style: TextStyle(
                        color: LightColor.lightblack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    widget.date.toString(),
                    style: TextStyle(
                        color: LightColor.lightblack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/time.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.uptime.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text("Lihat Detail"),
              ),
              body: WebView(
                initialUrl: url + widget.hardware.toString(),
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        );
      },
    );
  }
}
