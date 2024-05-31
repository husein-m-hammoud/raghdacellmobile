// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../Core/global_variables.dart';

class ProductsPackagesModel {
  List<Package>? data;
  int? code;

  ProductsPackagesModel({this.data, this.code});

  ProductsPackagesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Package>[];
      json['data'].forEach((v) {
        data!.add(Package.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class Package {
  var id;
  String? name;
  var isAvailable;
  var userPrice;
  var companyPrice;
  var thPartyApiId;
  String? image;
  String? note;
  var requirePlayerNumber;
  var isTiktok;

  Package(
      {this.id,
      this.name,
      this.isAvailable,
      this.userPrice,
      this.companyPrice,
      this.thPartyApiId,
      this.image,
      this.note,
      this.requirePlayerNumber,
      this.isTiktok});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // print(id);
    name = json['name'];
    // print(name);
    isAvailable = json['is_available'];
    // print(isAvailable);
    userPrice = type == "USER"? json['user_price']:json['company_price'];
    // print(userPrice);

    companyPrice = json['company_price'];
    // companyPrice!.toDouble();

    // print(companyPrice);
    thPartyApiId = json['th_party_api_id'];
    // print(thPartyApiId);
    image = json['image'];
    // print(image);
    note = json['note'];
    // print(note);
    requirePlayerNumber = json['require_player_number'];
    // print(requirePlayerNumber);
    isTiktok = json['is_tiktok'];
    // print(isTiktok);
    // print("\n");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    // print(id);
    data['name'] = name;
    // print(name);
    data['is_available'] = isAvailable;
    // print(isAvailable);
    data['user_price'] = userPrice;
    // print(userPrice);
    data['company_price'] = companyPrice;
    // print(companyPrice);
    data['th_party_api_id'] = thPartyApiId;
    // print(thPartyApiId);
    data['image'] = image;
    // print(image);
    data['note'] = note;
    // print(note);
    data['require_player_number'] = requirePlayerNumber;
    // print(requirePlayerNumber);
    data['is_tiktok'] = isTiktok;
    // print(isTiktok);
    return data;
  }
}
