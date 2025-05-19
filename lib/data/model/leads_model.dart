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
  String? name;
  String? surname;
  String? email;
  String? amount;
  String? store;

  Leads(
      {this.id, this.name, this.surname, this.email, this.amount, this.store});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    amount = json['amount'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['amount'] = amount;
    data['store'] = store;
    return data;
  }
}
