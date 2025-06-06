class AppraisalReportModel {
  List<AppraisalCertificateEmailReport>? appraisalCertificateEmailReport;

  AppraisalReportModel({this.appraisalCertificateEmailReport});

  AppraisalReportModel.fromJson(Map<String, dynamic> json) {
    if (json['appraisal_certificate_email_report'] != null) {
      appraisalCertificateEmailReport = <AppraisalCertificateEmailReport>[];
      json['appraisal_certificate_email_report'].forEach((v) {
        appraisalCertificateEmailReport!
            .add(AppraisalCertificateEmailReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (appraisalCertificateEmailReport != null) {
      data['appraisal_certificate_email_report'] =
          appraisalCertificateEmailReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppraisalCertificateEmailReport {
  String? id;
  String? pdfData;
  String? customerId;
  String? toEmail;
  String? storeId;
  String? status;
  String? createdBy;
  String? creationDate;
  String? expireDate;
  String? active;

  AppraisalCertificateEmailReport(
      {this.id,
      this.pdfData,
      this.customerId,
      this.toEmail,
      this.storeId,
      this.status,
      this.createdBy,
      this.creationDate,
      this.expireDate,
      this.active});

  AppraisalCertificateEmailReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pdfData = json['pdf_data'];
    customerId = json['customer_id'];
    toEmail = json['to_email'];
    storeId = json['store_id'];
    status = json['status'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
    expireDate = json['expire_date'];
    active = json['active'];
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
    data['expire_date'] = expireDate;
    data['active'] = active;
    return data;
  }
}
