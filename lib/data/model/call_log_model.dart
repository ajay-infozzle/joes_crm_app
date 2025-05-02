// enum CallType {incoming, outgoing, missed}

class CallLogModel {
  List<CallLog>? callLog;

  CallLogModel({this.callLog});

  CallLogModel.fromJson(Map<String, dynamic> json) {
    if (json['call_log'] != null) {
      callLog = <CallLog>[];
      json['call_log'].forEach((v) {
        callLog!.add(CallLog.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (callLog != null) {
      data['call_log'] = callLog!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CallLog {
  String? customerName;
  String? callType;
  String? callStatus;
  String? date;

  CallLog({this.customerName, this.callType, this.callStatus, this.date});

  CallLog.fromJson(Map<String, dynamic> json) {
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
