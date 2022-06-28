class DataStatistics {
  String? mtbf;
  String? mttr;
  String? availibility;

  DataStatistics({this.mtbf, this.mttr, this.availibility});

  DataStatistics.fromJson(Map<String, dynamic> json) {
    mtbf = json['mtbf'];
    mttr = json['mttr'];
    availibility = json['availibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mtbf'] = this.mtbf;
    data['mttr'] = this.mttr;
    data['availibility'] = this.availibility;
    return data;
  }
}
