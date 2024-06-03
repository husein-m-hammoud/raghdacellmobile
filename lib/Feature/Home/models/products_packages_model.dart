// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
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

class Requirement {
  String name;
  String label;

  Requirement({
    required this.name,
    required this.label,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      name: json['name'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'label': label,
    };
  }
}

class Package {
  var id;
  String? name;
  var isAvailable;
  var forceUnavailable;
  var automationReference;
  var productReference;
  //List<dynamic>?
  // List<dynamic>? requirements;
  var requirements; //
  var maximumQut;
  var minimumQut;
  var thPartyAs7abApi;
  var userPercentage;
  var companyPercentage;
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
      this.forceUnavailable,
      this.automationReference,
      this.productReference,
      this.requirements,
      // required this.requirements,
      this.maximumQut,
      this.minimumQut,
      this.thPartyAs7abApi,
      this.userPercentage,
      this.companyPercentage,
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
    forceUnavailable = json['force_unavailable'];
    automationReference = json['automation_reference'];
    productReference = json['product_reference'];

    requirements = json['requirements'];
    // Handling requirements field
    // print('eee');
    // print(json['requirements']);
    // if (json['requirements'] != null) {
    //   requirements = [];
    //   json['requirements'] =
    //   if (json['requirements'] is List) {
    //     (json['requirements'] as List).forEach((req) {
    //       requirements!.add(Requirement.fromJson(req));
    //     });
    //   } else if (json['requirements'] is Map) {
    //     requirements!.add(Requirement.fromJson(json['requirements']));
    //   }
    // }
    maximumQut = json['maximum_qut'] ?? 0;
    minimumQut = json['minimum_qut'] ?? 0;
    thPartyAs7abApi = json['th_party_as7ab_api'];
    userPercentage = json['user_percentage'] ?? 0;
    companyPercentage = json['company_percentage'] ?? 0;
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
      data['force_unavailable'] = forceUnavailable;
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
    if (requirements != null) {
      data['requirements'] = requirements!.map((req) => req.toJson()).toList();
    }
    //data['requirements'] = requirements;

    // print(isTiktok);
    return data;
  }
}
