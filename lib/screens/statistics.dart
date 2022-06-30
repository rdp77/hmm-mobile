// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hmm/models/dataStatistics.dart';
import 'package:hmm/utils/api.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  TooltipBehavior? _tooltipBehavior;
  late Future<DataStatistics> fetchDataStatistics;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    fetchDataStatistics = fetchStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Data Statistics",
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
          child: FutureBuilder<DataStatistics>(
            future: fetchDataStatistics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SfCartesianChart(
                          primaryYAxis: NumericAxis(
                              // Y axis labels will be rendered with currency format
                              labelFormat: '{value}%'),
                          enableAxisAnimation: true,
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(text: 'Statistics Uptime'),
                          // Enable tooltip
                          tooltipBehavior: _tooltipBehavior,
                          // Renders the marker
                          series: <LineSeries<StatsData, String>>[
                            LineSeries<StatsData, String>(
                                dataSource: <StatsData>[
                                  StatsData('Jan',
                                      snapshot.data!.availibility![0].total!),
                                  StatsData('Feb',
                                      snapshot.data!.availibility![1].total!),
                                  StatsData('Mar',
                                      snapshot.data!.availibility![2].total!),
                                  StatsData('Apr',
                                      snapshot.data!.availibility![3].total!),
                                  StatsData('May',
                                      snapshot.data!.availibility![4].total!),
                                  StatsData('Jun',
                                      snapshot.data!.availibility![5].total!),
                                  StatsData('Jul',
                                      snapshot.data!.availibility![6].total!),
                                  StatsData('Aug',
                                      snapshot.data!.availibility![7].total!),
                                  StatsData('Sep',
                                      snapshot.data!.availibility![8].total!),
                                  StatsData('Oct',
                                      snapshot.data!.availibility![9].total!),
                                  StatsData('Nov',
                                      snapshot.data!.availibility![10].total!),
                                  StatsData('Dec',
                                      snapshot.data!.availibility![11].total!),
                                ],
                                xValueMapper: (StatsData data, _) => data.year,
                                yValueMapper: (StatsData data, _) => data.value,
                                // Renders the marker
                                markerSettings: MarkerSettings(isVisible: true),
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true)),
                          ]),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 500,
                        width: double.infinity,
                        child: SfCartesianChart(
                            primaryYAxis: NumericAxis(
                                // Y axis labels will be rendered with currency format
                                labelFormat: '{value} Jam'),
                            enableAxisAnimation: true,
                            // Initialize category axis
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: 'Statistics Maintenance'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            // Enable tooltip
                            tooltipBehavior: _tooltipBehavior,
                            // Renders the marker
                            series: <LineSeries<StatsData, String>>[
                              LineSeries<StatsData, String>(
                                  name: "MTBF",
                                  dataSource: <StatsData>[
                                    StatsData(
                                        'Jan', snapshot.data!.mtbf![0].total!),
                                    StatsData(
                                        'Feb', snapshot.data!.mtbf![1].total!),
                                    StatsData(
                                        'Mar', snapshot.data!.mtbf![2].total!),
                                    StatsData(
                                        'Apr', snapshot.data!.mtbf![3].total!),
                                    StatsData(
                                        'May', snapshot.data!.mtbf![4].total!),
                                    StatsData(
                                        'Jun', snapshot.data!.mtbf![5].total!),
                                    StatsData(
                                        'Jul', snapshot.data!.mtbf![6].total!),
                                    StatsData(
                                        'Aug', snapshot.data!.mtbf![7].total!),
                                    StatsData(
                                        'Sep', snapshot.data!.mtbf![8].total!),
                                    StatsData(
                                        'Oct', snapshot.data!.mtbf![9].total!),
                                    StatsData(
                                        'Nov', snapshot.data!.mtbf![10].total!),
                                    StatsData(
                                        'Dec', snapshot.data!.mtbf![11].total!),
                                  ],
                                  xValueMapper: (StatsData data, _) =>
                                      data.year,
                                  yValueMapper: (StatsData data, _) =>
                                      data.value,
                                  // Renders the marker
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<StatsData, String>(
                                  name: "MTTR",
                                  dataSource: <StatsData>[
                                    StatsData(
                                        'Jan', snapshot.data!.mttr![0].total!),
                                    StatsData(
                                        'Feb', snapshot.data!.mttr![1].total!),
                                    StatsData(
                                        'Mar', snapshot.data!.mttr![2].total!),
                                    StatsData(
                                        'Apr', snapshot.data!.mttr![3].total!),
                                    StatsData(
                                        'May', snapshot.data!.mttr![4].total!),
                                    StatsData(
                                        'Jun', snapshot.data!.mttr![5].total!),
                                    StatsData(
                                        'Jul', snapshot.data!.mttr![6].total!),
                                    StatsData(
                                        'Aug', snapshot.data!.mttr![7].total!),
                                    StatsData(
                                        'Sep', snapshot.data!.mttr![8].total!),
                                    StatsData(
                                        'Oct', snapshot.data!.mttr![9].total!),
                                    StatsData(
                                        'Nov', snapshot.data!.mttr![10].total!),
                                    StatsData(
                                        'Dec', snapshot.data!.mttr![11].total!),
                                  ],
                                  xValueMapper: (StatsData data, _) =>
                                      data.year,
                                  yValueMapper: (StatsData data, _) =>
                                      data.value,
                                  // Renders the marker
                                  markerSettings:
                                      MarkerSettings(isVisible: true),
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ]),
                      ),
                    ],
                  ),
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
        ));
  }
}

class StatsData {
  StatsData(this.year, this.value);
  final String year;
  final double value;
}
