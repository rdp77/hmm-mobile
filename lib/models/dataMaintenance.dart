class DataMaintenance {
  int? total;
  List<Data>? data;

  DataMaintenance({this.total, this.data});

  DataMaintenance.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? code;
  String? hardwareCode;
  String? brand;
  String? mtbf;
  String? mttr;
  String? date;
  String? availibility;

  Data(
      {this.code,
      this.hardwareCode,
      this.brand,
      this.mtbf,
      this.mttr,
      this.date,
      this.availibility});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    hardwareCode = json['hardware_code'];
    brand = json['brand'];
    mtbf = json['mtbf'];
    mttr = json['mttr'];
    date = json['date'];
    availibility = json['availibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['hardware_code'] = this.hardwareCode;
    data['brand'] = this.brand;
    data['mtbf'] = this.mtbf;
    data['mttr'] = this.mttr;
    data['date'] = this.date;
    data['availibility'] = this.availibility;
    return data;
  }
}
