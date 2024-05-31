class SliderImageModel {
  List<MyImage>? images;
  int? code;

  SliderImageModel({this.images, this.code});

  SliderImageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      images = <MyImage>[];
      json['data'].forEach((v) {
        images!.add(MyImage.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (images != null) {
      data['data'] = images!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class MyImage {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;

  MyImage({this.id, this.image, this.createdAt, this.updatedAt});

  MyImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
