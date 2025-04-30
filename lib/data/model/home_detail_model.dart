class HomeDetailModel {
  List<PhoneLogs>? phoneLogs;

  HomeDetailModel({this.phoneLogs});

  HomeDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['phone_logs'] != null) {
      phoneLogs = <PhoneLogs>[];
      json['phone_logs'].forEach((v) {
        phoneLogs!.add(PhoneLogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (phoneLogs != null) {
      data['phone_logs'] = phoneLogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhoneLogs {
  String? customerName;
  String? callType;
  String? callStatus;
  String? date;

  PhoneLogs({this.customerName, this.callType, this.callStatus, this.date});

  PhoneLogs.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    callType = json['call_type'];
    callStatus = json['call_status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_name'] = customerName;
    data['call_type'] = callType;
    data['call_status'] = callStatus;
    data['date'] = date;
    return data;
  }
}
