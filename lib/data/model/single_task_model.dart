class SingleTaskModel {
  Task? task;

  SingleTaskModel({this.task});

  SingleTaskModel.fromJson(Map<String, dynamic> json) {
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (task != null) {
      data['task'] = task!.toJson();
    }
    return data;
  }
}

class Task {
  String? id;
  String? creationDate;
  String? modificationDate;
  String? createdBy;
  String? modifiedBy;
  String? completed;
  String? title;
  String? userId;
  String? assignorId;
  String? dueDate;
  String? completionDate;
  String? description;

  Task(
      {this.id,
      this.creationDate,
      this.modificationDate,
      this.createdBy,
      this.modifiedBy,
      this.completed,
      this.title,
      this.userId,
      this.assignorId,
      this.dueDate,
      this.completionDate,
      this.description});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creationDate = json['creation_date'];
    modificationDate = json['modification_date'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    completed = json['completed'];
    title = json['title'];
    userId = json['user_id'];
    assignorId = json['assignor_id'];
    dueDate = json['due_date'];
    completionDate = json['completion_date'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creation_date'] = creationDate;
    data['modification_date'] = modificationDate;
    data['created_by'] = createdBy;
    data['modified_by'] = modifiedBy;
    data['completed'] = completed;
    data['title'] = title;
    data['user_id'] = userId;
    data['assignor_id'] = assignorId;
    data['due_date'] = dueDate;
    data['completion_date'] = completionDate;
    data['description'] = description;
    return data;
  }
}
