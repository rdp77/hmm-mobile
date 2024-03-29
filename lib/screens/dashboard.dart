import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hmm/models/data_count.dart';
import 'package:hmm/utils/api.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _scanBarcode = 'Unknown';
  late Future<DataCount> fetchDataCount;
  String brands = '';
  String result = '';
  bool isAvailable = false;

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

  void getdata(code) async {
    var data = await searchData(code);
    setState(() {
      if (data.status == 'success') {
        result = data.data.toString();
        isAvailable = true;
      } else {
        result = data.data.toString();
        isAvailable = false;
      }
    });
  }

  void codeSearch(code) async {
    print(code);
    var data = await searchData(code);
    setState(() {
      if (data.status == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text("Lihat Detail"),
              ),
              body: WebView(
                initialUrl: data.data.toString(),
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data.data.toString()),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      // print(searchData(barcodeScanRes).then((value) => value.data?.toString()));
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      getdata(_scanBarcode);
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

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
                const SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _seeAllView(context, "Total Data"),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          _itemKeyPointsView("assets/images/admin.png",
                              snapshot.data!.users.toString(), "Administrator"),
                          const SizedBox(
                            width: 8,
                          ),
                          _itemKeyPointsView("assets/images/hardware.png",
                              snapshot.data!.hardware.toString(), "Hardware")
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          _itemKeyPointsView(
                              "assets/images/registered-trademark.png",
                              snapshot.data!.brands.toString(),
                              "Brands"),
                          SizedBox(
                            width: 8,
                          ),
                          _itemKeyPointsView("assets/images/activity-feed.png",
                              snapshot.data!.log.toString(), "Activity")
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
                              maxLength: 10,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Search Maintenance HW...",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff979899),
                                    fontWeight: FontWeight.w500),
                                contentPadding: EdgeInsets.all(16),
                                prefixIcon: Icon(
                                  CupertinoIcons.search,
                                  color: Color(0xff23AA49),
                                ),
                              ),
                              onChanged: (context) {
                                if (context.length == 10) {
                                  codeSearch(context);
                                }
                              },
                            ),
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
                          _categoriesView(context, "assets/images/tools.png",
                              "Maintenance Data", MyRoutes.maintenanceRoute),
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
                                          "assets/images/camera.png",
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
                                onTap: () => {
                                      scanQR(),
                                      if (isAvailable)
                                        {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Scaffold(
                                                appBar: AppBar(
                                                  elevation: 0,
                                                  title: Text("Lihat Detail"),
                                                ),
                                                body: WebView(
                                                  initialUrl: result,
                                                  javascriptMode: JavascriptMode
                                                      .unrestricted,
                                                ),
                                              ),
                                            ),
                                          )
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(result),
                                            backgroundColor: Colors.red,
                                          ))
                                        }
                                    }),
                          ),
                          _categoriesView(
                              context,
                              "assets/images/line-chart.png",
                              "Statistics Data",
                              MyRoutes.statisticsRoute),
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
            width: 10,
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
