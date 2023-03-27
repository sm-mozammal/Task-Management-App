class NewTaskModel {
  String? status;
  List<TaslData>? data;

  NewTaskModel({this.status, this.data});

  NewTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaslData>[];
      json['data'].forEach((v) {
        data!.add(new TaslData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaslData {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaslData({this.sId, this.title, this.description, this.status, this.createdDate});

  TaslData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['createdDate'] = this.createdDate;
    return data;
  }
}
