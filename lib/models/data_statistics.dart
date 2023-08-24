class DataStatistics {
  List<Mtbf>? mtbf;
  List<Mttr>? mttr;
  List<Availibility>? availibility;

  DataStatistics({this.mtbf, this.mttr, this.availibility});

  DataStatistics.fromJson(Map<String, dynamic> json) {
    if (json['mtbf'] != null) {
      mtbf = <Mtbf>[];
      json['mtbf'].forEach((v) {
        mtbf!.add(Mtbf.fromJson(v));
      });
    }
    if (json['mttr'] != null) {
      mttr = <Mttr>[];
      json['mttr'].forEach((v) {
        mttr!.add(Mttr.fromJson(v));
      });
    }
    if (json['availibility'] != null) {
      availibility = <Availibility>[];
      json['availibility'].forEach((v) {
        availibility!.add(Availibility.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mtbf != null) {
      data['mtbf'] = mtbf!.map((v) => v.toJson()).toList();
    }
    if (mttr != null) {
      data['mttr'] = mttr!.map((v) => v.toJson()).toList();
    }
    if (availibility != null) {
      data['availibility'] = availibility!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Mtbf {
  String? nama;
  double? total;

  Mtbf({this.nama, this.total});

  Mtbf.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['total'] = total;
    return data;
  }
}

class Mttr {
  String? nama;
  double? total;

  Mttr({this.nama, this.total});

  Mttr.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['total'] = total;
    return data;
  }
}

class Availibility {
  String? nama;
  double? total;

  Availibility({this.nama, this.total});

  Availibility.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    total = json['total'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['total'] = total;
    return data;
  }
}
