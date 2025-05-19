class StoreListModel {
  List<Stores>? stores;

  StoreListModel({this.stores});

  StoreListModel.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  String? id;
  String? name;
  String? ordering;
  String? published;
  String? creationDate;

  Stores(
      {this.id, this.name, this.ordering, this.published, this.creationDate});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ordering = json['ordering'];
    published = json['published'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ordering'] = ordering;
    data['published'] = published;
    data['creation_date'] = creationDate;
    return data;
  }
}
