class SalesListModel {
  List<Sales>? sales;

  SalesListModel({this.sales});

  SalesListModel.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <Sales>[];
      json['sales'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sales {
  String? id;
  String? storeId;
  String? photo;
  String? userId;
  String? customerId;
  String? saleDate;
  String? amount;

  Sales(
      {this.id,
      this.storeId,
      this.photo,
      this.userId,
      this.customerId,
      this.saleDate,
      this.amount});

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    photo = json['photo'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    saleDate = json['sale_date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['photo'] = photo;
    data['user_id'] = userId;
    data['customer_id'] = customerId;
    data['sale_date'] = saleDate;
    data['amount'] = amount;
    return data;
  }
}


/// single sale model

class SingleSaleModel {
  Sale? sale;

  SingleSaleModel({this.sale});

  SingleSaleModel.fromJson(Map<String, dynamic> json) {
    sale = json['sale'] != null ? Sale.fromJson(json['sale']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sale != null) {
      data['sale'] = sale!.toJson();
    }
    return data;
  }
}

class Sale {
  String? id;
  String? photo;
  String? photoBack;
  String? storeId;
  String? userId;
  String? customerId;
  String? receiptNo;
  String? saleDate;
  String? amount;
  String? notes;
  String? createdBy;
  String? creationDate;
  String? modifiedBy;
  String? modificationDate;
  String? checkedOut;
  String? checkedOutTime;
  List<SalesAssociates>? salesAssociates;

  Sale(
      {this.id,
      this.photo,
      this.photoBack,
      this.storeId,
      this.userId,
      this.customerId,
      this.receiptNo,
      this.saleDate,
      this.amount,
      this.notes,
      this.createdBy,
      this.creationDate,
      this.modifiedBy,
      this.modificationDate,
      this.checkedOut,
      this.checkedOutTime,
      this.salesAssociates});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    photoBack = json['photo_back'];
    storeId = json['store_id'];
    userId = json['user_id'];
    customerId = json['customer_id'];
    receiptNo = json['receipt_no'];
    saleDate = json['sale_date'];
    amount = json['amount'];
    notes = json['notes'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
    modifiedBy = json['modified_by'];
    modificationDate = json['modification_date'];
    checkedOut = json['checked_out'];
    checkedOutTime = json['checked_out_time'];
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
    data['photo'] = photo;
    data['photo_back'] = photoBack;
    data['store_id'] = storeId;
    data['user_id'] = userId;
    data['customer_id'] = customerId;
    data['receipt_no'] = receiptNo;
    data['sale_date'] = saleDate;
    data['amount'] = amount;
    data['notes'] = notes;
    data['created_by'] = createdBy;
    data['creation_date'] = creationDate;
    data['modified_by'] = modifiedBy;
    data['modification_date'] = modificationDate;
    data['checked_out'] = checkedOut;
    data['checked_out_time'] = checkedOutTime;
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
