// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hmm/models/data_maintenance.dart';
import 'package:hmm/utils/api.dart';
import 'package:hmm/widgets/item.dart';

class MaintenanceScreen extends StatefulWidget {
  MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  late Future<DataMaintenance> fetchDataMaintenance;

  @override
  void initState() {
    super.initState();
    fetchDataMaintenance = fetchMaintenance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Data Maintenance",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<DataMaintenance>(
          future: fetchDataMaintenance,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // ignore: avoid_unnecessary_containers
              return Column(
                children: [
                  Center(
                    child: _itemKeyPointsView(snapshot.data!.total.toString(),
                        "Total Data Maintenance"),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(
                          code: snapshot.data!.data![index].code,
                          hardware: snapshot.data!.data![index].hardwareCode,
                          uptime: snapshot.data!.data![index].availibility,
                          mtbf: snapshot.data!.data![index].mtbf,
                          mttr: snapshot.data!.data![index].mttr,
                          date: snapshot.data!.data![index].date,
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

Widget _itemKeyPointsView(String title, String desc) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Color(0xffF1F1F5))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff23AA49)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(desc, style: TextStyle(fontSize: 14, color: Color(0xff979899))),
        ],
      ));
}
