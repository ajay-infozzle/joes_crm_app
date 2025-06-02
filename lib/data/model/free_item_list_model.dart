class FreeItemListModel {
  List<Freeitems>? freeitems;

  FreeItemListModel({this.freeitems});

  FreeItemListModel.fromJson(Map<String, dynamic> json) {
    if (json['freeitems'] != null) {
      freeitems = <Freeitems>[];
      json['freeitems'].forEach((v) {
        freeitems!.add(Freeitems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (freeitems != null) {
      data['freeitems'] = freeitems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Freeitems {
  String? id;
  String? creationDate;
  String? modificationDate;
  String? createdBy;
  String? modifiedBy;
  String? name;
  String? surname;
  String? email;

  Freeitems(
      {this.id,
      this.creationDate,
      this.modificationDate,
      this.createdBy,
      this.modifiedBy,
      this.name,
      this.surname,
      this.email});

  Freeitems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creation_date'];
    modificationDate = json['modification_date'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creation_date'] = creationDate;
    data['modification_date'] = modificationDate;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    return data;
  }
}
