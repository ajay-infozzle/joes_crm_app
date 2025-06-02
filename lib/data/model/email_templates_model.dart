class EmailTemplatesModel {
  List<Emailtpls>? emailtpls;

  EmailTemplatesModel({this.emailtpls});

  EmailTemplatesModel.fromJson(Map<String, dynamic> json) {
    if (json['emailtpls'] != null) {
      emailtpls = <Emailtpls>[];
      json['emailtpls'].forEach((v) {
        emailtpls!.add(Emailtpls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emailtpls != null) {
      data['emailtpls'] = emailtpls!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emailtpls {
  String? id;
  String? title;
  String? type;
  String? subject;
  String? content;
  String? approved;
  String? createdBy;
  String? creationDate;
  String? modifiedBy;
  String? modificationDate;

  Emailtpls(
      {this.id,
      this.title,
      this.type,
      this.subject,
      this.content,
      this.approved,
      this.createdBy,
      this.creationDate,
      this.modifiedBy,
      this.modificationDate});

  Emailtpls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    subject = json['subject'];
    content = json['content'];
    approved = json['approved'];
    createdBy = json['created_by'];
    creationDate = json['creation_date'];
    modifiedBy = json['modified_by'];
    modificationDate = json['modification_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['subject'] = subject;
    data['content'] = content;
    data['approved'] = approved;
    data['created_by'] = createdBy;
    data['creation_date'] = creationDate;
    data['modified_by'] = modifiedBy;
    data['modification_date'] = modificationDate;
    return data;
  }
}
