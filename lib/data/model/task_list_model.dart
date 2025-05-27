class TaskListModel {
  List<Tasks>? tasks;

  TaskListModel({this.tasks});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
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

  Tasks(
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

  Tasks.fromJson(Map<String, dynamic> json) {
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
