// class Customer {
//   final String name;
//   final String id;
//   final String store;

//   Customer({required this.name, required this.id, required this.store});
// }

class CustomerListModel {
  List<Customers>? customers;

  CustomerListModel({this.customers});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Customers>[];
      json['customers'].forEach((v) {
        customers!.add(Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customers != null) {
      data['customers'] = customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  String? id;
  String? name;
  String? spouseName;
  String? surname;
  String? store;

  Customers({this.id, this.name, this.spouseName, this.surname, this.store});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    spouseName = json['spouse_name'];
    surname = json['surname'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['spouse_name'] = spouseName;
    data['surname'] = surname;
    data['store'] = store;
    return data;
  }
}
