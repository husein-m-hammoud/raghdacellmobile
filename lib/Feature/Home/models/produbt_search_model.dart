// ignore_for_file: prefer_typing_uninitialized_variables

class ProductsSearchResaultModel {
  List<ProductResault>? productResault;
  int? code;

  ProductsSearchResaultModel({this.productResault, this.code});

  ProductsSearchResaultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      productResault = <ProductResault>[];
      json['data'].forEach((v) {
        productResault!.add(ProductResault.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productResault != null) {
      data['data'] = productResault!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class ProductResault {
  var id;
  var pkey;
  var name;
  var note;
  var number;
  var minimumQut;
  var minimumQutNote;
  var available;
  var userPrice;
  var secUserPrice;
  var secCompanyPrice;
  var companyPrice;
  var thPartyApiId;
  var requirePlayerNumber;
  var image;
  List<ProductAdditionalServices>? productAdditionalServices;

  ProductResault(
      {this.id,
      this.pkey,
      this.name,
      this.note,
      this.number,
      this.minimumQut,
      this.minimumQutNote,
      this.available,
      this.userPrice,
      this.secUserPrice,
      this.secCompanyPrice,
      this.companyPrice,
      this.thPartyApiId,
      this.requirePlayerNumber,
      this.image,
      this.productAdditionalServices});

  ProductResault.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkey = json['pkey'];
    name = json['name'];
    note = json['note'];
    number = json['number'];
    minimumQut = json['minimum_qut'];
    minimumQutNote = json['minimum_qut_note'];
    available = json['available'];
    userPrice = json['user_price'];
    secUserPrice = json['sec_user_price'];
    secCompanyPrice = json['sec_company_price'];
    companyPrice = json['company_price'];
    thPartyApiId = json['th_party_api_id'];
    requirePlayerNumber = json['require_player_number'];
    image = json['image'];
    if (json['product_additional_services'] != null) {
      productAdditionalServices = <ProductAdditionalServices>[];
      json['product_additional_services'].forEach((v) {
        productAdditionalServices!.add(ProductAdditionalServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pkey'] = pkey;
    data['name'] = name;
    data['note'] = note;
    data['number'] = number;
    data['minimum_qut'] = minimumQut;
    data['minimum_qut_note'] = minimumQutNote;
    data['available'] = available;
    data['user_price'] = userPrice;
    data['sec_user_price'] = secUserPrice;
    data['sec_company_price'] = secCompanyPrice;
    data['company_price'] = companyPrice;
    data['th_party_api_id'] = thPartyApiId;
    data['require_player_number'] = requirePlayerNumber;
    data['image'] = image;
    if (productAdditionalServices != null) {
      data['product_additional_services'] =
          productAdditionalServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductAdditionalServices {
  var id;
  var type;
  var userPrice;
  var companyPrice;
  var note;
  var minimumQut;
  var minimumQutNote;

  ProductAdditionalServices(
      {this.id,
      this.type,
      this.userPrice,
      this.companyPrice,
      this.note,
      this.minimumQut,
      this.minimumQutNote});

  ProductAdditionalServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userPrice = json['user_price'];
    companyPrice = json['company_price'];
    note = json['note'];
    minimumQut = json['minimum_qut'];
    minimumQutNote = json['minimum_qut_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['user_price'] = userPrice;
    data['company_price'] = companyPrice;
    data['note'] = note;
    data['minimum_qut'] = minimumQut;
    data['minimum_qut_note'] = minimumQutNote;
    return data;
  }
}
