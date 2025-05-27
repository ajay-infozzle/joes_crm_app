class LeadsModel {
  List<Leads>? leads;

  LeadsModel({this.leads});

  LeadsModel.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(Leads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leads != null) {
      data['leads'] = leads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leads {
  String? id;
  String? customerId;
  String? status;
  String? photo;
  String? title;
  String? name;
  String? surname;
  String? email;
  String? followDate;
  String? amount;
  String? salesAssoc2;
  String? store;
  String? creationDate;
  String? createdBy;

  Leads(
      {this.id,
      this.customerId,
      this.status,
      this.photo,
      this.title,
      this.name,
      this.surname,
      this.email,
      this.followDate,
      this.amount,
      this.salesAssoc2,
      this.store,
      this.creationDate,
      this.createdBy});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    status = json['status'];
    photo = json['photo'];
    title = json['title'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    followDate = json['follow_date'];
    amount = json['amount'];
    salesAssoc2 = json['sales_assoc_2'];
    store = json['store'];
    creationDate = json['creation_date'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['status'] = status;
    data['photo'] = photo;
    data['title'] = title;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['follow_date'] = followDate;
    data['amount'] = amount;
    data['sales_assoc_2'] = salesAssoc2;
    data['store'] = store;
    data['creation_date'] = creationDate;
    data['created_by'] = createdBy;
    return data;
  }
}
