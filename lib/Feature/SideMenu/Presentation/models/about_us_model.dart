class AboutUsModel {
  Data? data;
  int? code;

  AboutUsModel({this.data, this.code});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class Data {
  List<AboutUsImages>? aboutUsImages;
  String? aboutUsText;

  Data({this.aboutUsImages, this.aboutUsText});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['about_us_images'] != null) {
      aboutUsImages = <AboutUsImages>[];
      json['about_us_images'].forEach((v) {
        aboutUsImages!.add(AboutUsImages.fromJson(v));
      });
    }
    aboutUsText = json['about_us_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aboutUsImages != null) {
      data['about_us_images'] = aboutUsImages!.map((v) => v.toJson()).toList();
    }
    data['about_us_text'] = aboutUsText;
    return data;
  }
}

class AboutUsImages {
  int? id;
  String? image;

  AboutUsImages({this.id, this.image});

  AboutUsImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
