class FAQModel {
  bool? success;
  List<FAQ>? data;
  String? message;

  FAQModel({this.success, this.data, this.message});

  FAQModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FAQ>[];
      json['data'].forEach((v) {
        data!.add(FAQ.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class FAQ {
  int? id;
  String? question;
  String? answer;
  String? category;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  FAQ(
      {this.id,
        this.question,
        this.answer,
        this.category,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  FAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    category = json['category'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['category'] = category;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
