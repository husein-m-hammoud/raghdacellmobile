class ContactUsInfoTextModel {
  Data? data;
  int? code;

  ContactUsInfoTextModel({this.data, this.code});

  ContactUsInfoTextModel.fromJson(Map<String, dynamic> json) {
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
  String? instagram;
  String? facebook;
  String? whatsapp;
  String? email;
  String? firstPhoneNumber;
  String? secondPhoneNumber;
  String? tiktok;

  Data(
      {this.instagram,
      this.facebook,
      this.whatsapp,
      this.email,
      this.firstPhoneNumber,
      this.secondPhoneNumber,
      this.tiktok});

  Data.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    firstPhoneNumber = json['first_phone_number'];
    secondPhoneNumber = json['second_phone_number'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['whatsapp'] = whatsapp;
    data['email'] = email;
    data['first_phone_number'] = firstPhoneNumber;
    data['second_phone_number'] = secondPhoneNumber;
    data['tiktok'] = tiktok;
    return data;
  }
}
