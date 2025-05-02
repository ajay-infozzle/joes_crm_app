class SingleCustomerModel {
  Customer? customer;

  SingleCustomerModel({this.customer});

  SingleCustomerModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? name;
  String? spouseName;
  String? surname;
  String? email;
  String? wifeEmail;
  String? country;
  String? store;
  String? phone;
  String? wifePhone;
  String? birthday;
  String? wifeBirthday;
  String? anniversary;
  List<String>? sales;
  List<String>? smsLog;
  List<ActivityStream>? activityStream;
  List<String>? wishList;

  Customer(
      {this.id,
      this.name,
      this.spouseName,
      this.surname,
      this.email,
      this.wifeEmail,
      this.country,
      this.store,
      this.phone,
      this.wifePhone,
      this.birthday,
      this.wifeBirthday,
      this.anniversary,
      this.sales,
      this.smsLog,
      this.activityStream,
      this.wishList});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    spouseName = json['spouse_name'];
    surname = json['surname'];
    email = json['email'];
    wifeEmail = json['wife_email'];
    country = json['country'];
    store = json['store'];
    phone = json['phone'];
    wifePhone = json['wife_phone'];
    birthday = json['birthday'];
    wifeBirthday = json['wife_birthday'];
    anniversary = json['anniversary'];
    sales = json['sales'].cast<String>();
    smsLog = json['sms_log'].cast<String>();
    if (json['activity_stream'] != null) {
      activityStream = <ActivityStream>[];
      json['activity_stream'].forEach((v) {
        activityStream!.add(ActivityStream.fromJson(v));
      });
    }
    wishList = json['wish_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['spouse_name'] = spouseName;
    data['surname'] = surname;
    data['email'] = email;
    data['wife_email'] = wifeEmail;
    data['country'] = country;
    data['store'] = store;
    data['phone'] = phone;
    data['wife_phone'] = wifePhone;
    data['birthday'] = birthday;
    data['wife_birthday'] = wifeBirthday;
    data['anniversary'] = anniversary;
    data['sales'] = sales;
    data['sms_log'] = smsLog;
    if (activityStream != null) {
      data['activity_stream'] =
          activityStream!.map((v) => v.toJson()).toList();
    }
    data['wish_list'] = wishList;
    return data;
  }
}

class ActivityStream {
  String? user;
  String? date;
  String? dateAgo;
  String? action;

  ActivityStream({this.user, this.date, this.dateAgo, this.action});

  ActivityStream.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    date = json['date'];
    dateAgo = json['date_ago'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['date'] = date;
    data['date_ago'] = dateAgo;
    data['action'] = action;
    return data;
  }
}
