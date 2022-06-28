// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hmm/models/dataCount.dart';
import 'package:hmm/utils/api.dart';
import '../utils/routes.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _scanBarcode = 'Unknown';
  late Future<DataCount> fetchDataCount;
  String brands = '';

  @override
  void initState() {
    super.initState();
    fetchDataCount = fetchCount();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DataCount>(
        future: fetchDataCount,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _seeAllView(context, "Total Data"),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          _itemKeyPointsView("assets/images/organic.png",
                              snapshot.data!.users.toString(), "Total Admin"),
                          SizedBox(
                            width: 8,
                          ),
                          _itemKeyPointsView(
                              "assets/images/expiration.png",
                              snapshot.data!.hardware.toString(),
                              "Total Hardware")
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          _itemKeyPointsView("assets/images/reviews.png",
                              snapshot.data!.brands.toString(), "Total Merk"),
                          SizedBox(
                            width: 8,
                          ),
                          _itemKeyPointsView("assets/images/calories.png",
                              snapshot.data!.log.toString(), "Total Aktivitas")
                        ],
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF3F5F7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search Maintenance",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff979899),
                                      fontWeight: FontWeight.w500),
                                  contentPadding: EdgeInsets.all(16),
                                  prefixIcon: Icon(
                                    CupertinoIcons.search,
                                    color: Color(0xff23AA49),
                                  ),
                                )),
                          )),
                      SizedBox(
                        height: 36,
                      ),
                      _seeAllView(context, "Menu"),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          _categoriesView(context, "assets/images/fruits.png",
                              "Data Maintenance", MyRoutes.maintenanceRoute),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Color(0xffF3F5F7),
                                      radius: 32,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          "assets/images/diary.png",
                                          scale: 4.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Scan Barcode",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                onTap: () => scanQR()),
                          ),
                          _categoriesView(context, "assets/images/meat.png",
                              "Data Statistics", MyRoutes.maintenanceRoute),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _seeAllView(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _categoriesView(
      BuildContext context, String imagePath, String catName, String route) {
    return Expanded(
      flex: 1,
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffF3F5F7),
                radius: 32,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    imagePath,
                    scale: 4.0,
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                catName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, route);
          }),
    );
  }
}

Widget _itemKeyPointsView(String imagePath, String title, String desc) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Color(0xffF1F1F5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff23AA49)),
              ),
              SizedBox(
                height: 8,
              ),
              Text(desc,
                  style: TextStyle(fontSize: 14, color: Color(0xff979899))),
            ],
          )
        ],
      ),
    ),
  );
}
