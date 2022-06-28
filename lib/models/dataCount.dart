class DataCount {
  int? users;
  int? hardware;
  int? brands;
  int? log;

  DataCount({this.users, this.hardware, this.brands, this.log});

  DataCount.fromJson(Map<String, dynamic> json) {
    users = json['users'];
    hardware = json['hardware'];
    brands = json['brands'];
    log = json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users'] = this.users;
    data['hardware'] = this.hardware;
    data['brands'] = this.brands;
    data['log'] = this.log;
    return data;
  }
}
