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
  String? title;
  String? spouseName;
  String? surname;
  String? email;
  String? wifeEmail;
  String? address;
  String? addressVerified;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? store;
  String? phone;
  String? wifePhone;
  String? vip;
  String? ship;
  String? storeId;
  String? birthday;
  String? wifeBirthday;
  String? anniversary;
  String? totalSales;
  String? lastSaleDate;
  String? notes;
  String? photo;
  List<Sales>? sales;
  List<SmsLog>? smsLog;
  List<ActivityStream>? activityStream;
  List<WishList>? wishList;
  List<CommunicationLog>? communicationLog;

  Customer(
      {this.id,
      this.name,
      this.title,
      this.spouseName,
      this.surname,
      this.email,
      this.wifeEmail,
      this.address,
      this.addressVerified,
      this.city,
      this.ship,
      this.state,
      this.storeId,
      this.vip,
      this.zip,
      this.country,
      this.store,
      this.phone,
      this.wifePhone,
      this.birthday,
      this.wifeBirthday,
      this.anniversary,
      this.totalSales,
      this.lastSaleDate,
      this.notes,
      this.photo,
      this.sales,
      this.smsLog,
      this.activityStream,
      this.communicationLog,
      this.wishList});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    spouseName = json['spouse_name'];
    surname = json['surname'];
    email = json['email'];
    wifeEmail = json['wife_email'];
    address = json['address'];
    addressVerified = json['address_verified'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    vip = json['vip'];
    ship = json['ship'];
    storeId = json['store_id'];
    country = json['country'];
    store = json['store'];
    phone = json['phone'];
    wifePhone = json['wife_phone'];
    birthday = json['birthday'];
    wifeBirthday = json['wife_birthday'];
    anniversary = json['anniversary'];
    totalSales = json['total_sales'];
    lastSaleDate = json['last_sale_date'];
    notes = json['notes'];
    photo = json['photo'];
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
    if (json['sms_log'] != null) {
      smsLog = <SmsLog>[];
      json['sms_log'].forEach((v) {
        smsLog!.add(SmsLog.fromJson(v));
      });
    }
    if (json['activity_stream'] != null) {
      activityStream = <ActivityStream>[];
      json['activity_stream'].forEach((v) {
        activityStream!.add(ActivityStream.fromJson(v));
      });
    }
    if (json['communication_log'] != null) {
      communicationLog = <CommunicationLog>[];
      json['communication_log'].forEach((v) {
        communicationLog!.add(CommunicationLog.fromJson(v));
      });
    }
    if (json['wish_list'] != null) {
      wishList = <WishList>[];
      json['wish_list'].forEach((v) {
        wishList!.add(WishList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['title'] = title;
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
    data['total_sales'] = totalSales;
    data['last_sale_date'] = lastSaleDate;
    data['notes'] = notes;
    data['photo'] = photo;
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    if (smsLog != null) {
      data['sms_log'] = smsLog!.map((v) => v.toJson()).toList();
    }
    if (activityStream != null) {
      data['activity_stream'] =
          activityStream!.map((v) => v.toJson()).toList();
    }
    if (communicationLog != null) {
      data['communication_log'] =
          communicationLog!.map((v) => v.toJson()).toList();
    }
    if (wishList != null) {
      data['wish_list'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Sales {
  String? id;
  String? saleDate;
  String? store;
  String? amount;
  List<SalesAssociates>? salesAssociates;

  Sales({this.id, this.saleDate, this.store, this.amount, this.salesAssociates});

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleDate = json['sale_date'];
    store = json['store'];
    amount = json['amount'];
    if (json['sales_associates'] != null) {
      salesAssociates = <SalesAssociates>[];
      json['sales_associates'].forEach((v) {
        salesAssociates!.add(SalesAssociates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale_date'] = saleDate;
    data['store'] = store;
    data['amount'] = amount;
    if (salesAssociates != null) {
      data['sales_associates'] =
          salesAssociates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesAssociates {
  String? id;
  String? name;

  SalesAssociates({this.id, this.name});

  SalesAssociates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class SmsLog {
  String? type;
  String? from;
  String? to;
  String? date;
  String? message;

  SmsLog({this.type, this.from, this.to, this.date, this.message});

  SmsLog.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    from = json['from'];
    to = json['to'];
    date = json['date'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['from'] = from;
    data['to'] = to;
    data['date'] = date;
    data['message'] = message;
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

class WishList {
  String? id;
  String? photo;
  String? product;
  String? price;
  List<SalesAssociates>? salesAssociates;
  String? creationDate;

  WishList(
      {this.id,
      this.photo,
      this.product,
      this.price,
      this.salesAssociates,
      this.creationDate});

  WishList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    product = json['product'];
    price = json['price'];
    if (json['sales_associates'] != null) {
      salesAssociates = <SalesAssociates>[];
      json['sales_associates'].forEach((v) {
        salesAssociates!.add(SalesAssociates.fromJson(v));
      });
    }
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['product'] = product;
    data['price'] = price;
    if (salesAssociates != null) {
      data['sales_associates'] =
          salesAssociates!.map((v) => v.toJson()).toList();
    }
    data['creation_date'] = creationDate;
    return data;
  }
}

class CommunicationLog {
  String? user;
  String? date;
  String? dateAgo;
  String? action;

  CommunicationLog({this.user, this.date, this.dateAgo, this.action});

  CommunicationLog.fromJson(Map<String, dynamic> json) {
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