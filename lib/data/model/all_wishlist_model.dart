class AllwishlistModel {
  List<Wishlist>? wishlist;

  AllwishlistModel({this.wishlist});

  AllwishlistModel.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wishlist != null) {
      data['wishlist'] = wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  String? id;
  String? photo;
  String? customer;
  String? product;
  String? followDate;
  String? price;
  String? salesAssoc2;
  String? createdBy;
  String? creationDate;

  Wishlist(
      {this.id,
      this.photo,
      this.customer,
      this.product,
      this.followDate,
      this.price,
      this.salesAssoc2,
      this.createdBy,
      this.creationDate});

  Wishlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    customer = json['customer'];
    product = json['product'];
    followDate = json['follow_date'];
    price = json['price'];
    salesAssoc2 = json['sales_assoc_2'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['photo'] = photo;
    data['customer'] = customer;
    data['product'] = product;
    data['follow_date'] = followDate;
    data['price'] = price;
    data['sales_assoc_2'] = salesAssoc2;
    data['created_by'] = createdBy;
    data['creation_date'] = creationDate;
    return data;
  }
}



class SingleWishModel {
  Wish? wish;

  SingleWishModel({this.wish});

  SingleWishModel.fromJson(Map<String, dynamic> json) {
    wish = json['wish'] != null ? Wish.fromJson(json['wish']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wish != null) {
      data['wish'] = wish!.toJson();
    }
    return data;
  }
}

class Wish {
  String? id;
  String? customer;
  String? photo;
  String? product;
  String? referenceNo;
  String? price;
  String? createdBy;
  String? creationDate;
  String? modifiedBy;
  String? modificationDate;
  String? followDate;
  String? salesAssoc2;
  List<SalesAssociates>? salesAssociates;

  Wish(
      {this.id,
      this.customer,
      this.photo,
      this.product,
      this.referenceNo,
      this.price,
      this.createdBy,
      this.creationDate,
      this.modifiedBy,
      this.modificationDate,
      this.followDate,
      this.salesAssoc2,
      this.salesAssociates});

  Wish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    photo = json['photo'];
    product = json['product'];
    referenceNo = json['reference_no'];
    price = json['price'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
    modifiedBy = json['modified_by'];
    modificationDate = json['modification_date'];
    followDate = json['follow_date'];
    salesAssoc2 = json['sales_assoc_2'];
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
    data['customer'] = customer;
    data['photo'] = photo;
    data['product'] = product;
    data['reference_no'] = referenceNo;
    data['price'] = price;
    data['created_by'] = createdBy;
    data['creation_date'] = creationDate;
    data['modified_by'] = modifiedBy;
    data['modification_date'] = modificationDate;
    data['follow_date'] = followDate;
    data['sales_assoc_2'] = salesAssoc2;
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
