class EmailCampaignListModel {
  List<Emailcampaigns>? emailcampaigns;

  EmailCampaignListModel({this.emailcampaigns});

  EmailCampaignListModel.fromJson(Map<String, dynamic> json) {
    if (json['emailcampaigns'] != null) {
      emailcampaigns = <Emailcampaigns>[];
      json['emailcampaigns'].forEach((v) {
        emailcampaigns!.add(Emailcampaigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emailcampaigns != null) {
      data['emailcampaigns'] =
          emailcampaigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emailcampaigns {
  String? id;
  String? title;
  String? status;
  String? creationDate;
  String? createdBy;

  Emailcampaigns(
      {this.id, this.title, this.status, this.creationDate, this.createdBy});

  Emailcampaigns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    creationDate = json['creation_date'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['creation_date'] = creationDate;
    data['created_by'] = createdBy;
    return data;
  }
}


class SingleEmailCampaignModel {
  Emailcampaign? emailcampaign;

  SingleEmailCampaignModel({this.emailcampaign});

  SingleEmailCampaignModel.fromJson(Map<String, dynamic> json) {
    emailcampaign = json['emailcampaign'] != null
        ? Emailcampaign.fromJson(json['emailcampaign'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emailcampaign != null) {
      data['emailcampaign'] = emailcampaign!.toJson();
    }
    return data;
  }
}

class Emailcampaign {
  String? id;
  String? title;
  String? subject;
  String? text;
  String? status;
  String? refType;
  String? filters;
  String? sendingDate;
  String? creationDate;
  String? modificationDate;
  String? createdBy;
  String? modifiedBy;

  Emailcampaign(
      {this.id,
      this.title,
      this.subject,
      this.text,
      this.status,
      this.refType,
      this.filters,
      this.sendingDate,
      this.creationDate,
      this.modificationDate,
      this.createdBy,
      this.modifiedBy});

  Emailcampaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subject = json['subject'];
    text = json['text'];
    status = json['status'];
    refType = json['ref_type'];
    filters = json['filters'];
    sendingDate = json['sending_date'];
    creationDate = json['creation_date'];
    modificationDate = json['modification_date'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subject'] = subject;
    data['text'] = text;
    data['status'] = status;
    data['ref_type'] = refType;
    data['filters'] = filters;
    data['sending_date'] = sendingDate;
    data['creation_date'] = creationDate;
    data['modification_date'] = modificationDate;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    return data;
  }
}
