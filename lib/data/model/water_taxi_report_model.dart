class WaterTaxiReportModel {
  List<WaterTaxiEmailReportData>? waterTaxiEmailReportData;

  WaterTaxiReportModel({this.waterTaxiEmailReportData});

  WaterTaxiReportModel.fromJson(Map<String, dynamic> json) {
    if (json['water_taxi_email_report_data'] != null) {
      waterTaxiEmailReportData = <WaterTaxiEmailReportData>[];
      json['water_taxi_email_report_data'].forEach((v) {
        waterTaxiEmailReportData!.add(WaterTaxiEmailReportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (waterTaxiEmailReportData != null) {
      data['water_taxi_email_report_data'] =
          waterTaxiEmailReportData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterTaxiEmailReportData {
  String? id;
  String? pdfData;
  String? customerId;
  String? toEmail;
  String? storeId;
  String? status;
  String? createdBy;
  String? creationDate;

  WaterTaxiEmailReportData(
      {this.id,
      this.pdfData,
      this.customerId,
      this.toEmail,
      this.storeId,
      this.status,
      this.createdBy,
      this.creationDate});

  WaterTaxiEmailReportData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pdfData = json['pdf_data'];
    customerId = json['customer_id'];
    toEmail = json['to_email'];
    storeId = json['store_id'];
    status = json['status'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pdf_data'] = pdfData;
    data['customer_id'] = customerId;
    data['to_email'] = toEmail;
    data['store_id'] = storeId;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['creation_date'] = creationDate;
    return data;
  }
}
