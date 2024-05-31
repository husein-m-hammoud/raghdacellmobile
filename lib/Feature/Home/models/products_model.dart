// ignore_for_file: prefer_typing_uninitialized_variables

import '../../../Core/global_variables.dart';

class ProductsModel {
  Data? data;
  int? code;

  ProductsModel({this.data, this.code});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] is Map ? Data.fromJson(json['data']) : Data.fromJson(json);
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
  var currentPage;
  List<Product>? products;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  Data(
      {this.currentPage,
      this.products,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      products = <Product>[];
        json['data'].forEach((v) {
          products!.add(Product.fromJson(v));
        });

    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (products != null) {
      data['data'] = products!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Product {
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
  var currency;

  Product(
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
      this.productAdditionalServices,
      this.currency});

  Product.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    pkey = json['pkey'];
    name = json['name'];
    note = json['note'];
    number = json['number'];
    minimumQut = json['minimum_qut'];
    minimumQutNote = json['minimum_qut_note'];
    available = json['available'];
    userPrice = type == "USER"? json['user_price']:json['company_price'];
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

    currency = json['currency'];
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
    data['currency'] = currency;
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
  var currency;

  ProductAdditionalServices(
      {this.id,
      this.type,
      this.userPrice,
      this.companyPrice,
      this.note,
      this.minimumQut,
      this.minimumQutNote,
      this.currency});

  ProductAdditionalServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    userPrice = json['user_price'];
    companyPrice = json['company_price'];
    note = json['note'];
    minimumQut = json['minimum_qut'];
    minimumQutNote = json['minimum_qut_note'];
    currency = json['currency'];
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
    data['currency'] = currency;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}




// // ignore_for_file: prefer_typing_uninitialized_variables

// class ProductsModel {
//   Data? data;
//   int code;

//   ProductsModel({this.data, this.code});

//   ProductsModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     code = json['code'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['code'] = code;
//     return data;
//   }
// }

// class Data {
//   int? currentPage;
//   List<Product>? products;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   List<Links>? links;
//   String? nextPageUrl;
//   String? path;
//   int? perPage;
//   String? prevPageUrl;
//   int? to;
//   int? total;

//   Data(
//       {this.currentPage,
//       this.products,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.links,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});

//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       products = <Product>[];
//       json['data'].forEach((v) {
//         products!.add(Product.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       links = <Links>[];
//       json['links'].forEach((v) {
//         links!.add(Links.fromJson(v));
//       });
//     }
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['current_page'] = currentPage;
//     if (products != null) {
//       data['data'] = products!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = firstPageUrl; 
//     data['from'] = from;
//     data['last_page'] = lastPage;
//     data['last_page_url'] = lastPageUrl;
//     if (links != null) {
//       data['links'] = links!.map((v) => v.toJson()).toList();
//     }
//     data['next_page_url'] = nextPageUrl;
//     data['path'] = path;
//     data['per_page'] = perPage;
//     data['prev_page_url'] = prevPageUrl;
//     data['to'] = to;
//     data['total'] = total;
//     return data;
//   }
// }

// class Product {
//   int? id;
//   String? name;
//   String? note;
//   int? number;
//   var minimumQut;
//   String? minimumQutNote;
//   int? available;
//   var userPrice;
//   var secUserPrice;
//   var secCompanyPrice;
//   var companyPrice;
//   var thPartyApiId;
//   int? requirePlayerNumber;
//   String? image;
//   List<ProductAdditionalServices>? productAdditionalServices;

//   Product(
//       {this.id,
//       this.name,
//       this.note,
//       this.number,
//       this.minimumQut,
//       this.minimumQutNote,
//       this.available,
//       this.userPrice,
//       this.secUserPrice,
//       this.secCompanyPrice,
//       this.companyPrice,
//       this.thPartyApiId,
//       this.requirePlayerNumber,
//       this.image,
//       this.productAdditionalServices});

//   Product.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     note = json['note'];
//     number = json['number'];
//     minimumQut = json['minimum_qut'];
//     minimumQutNote = json['minimum_qut_note'];
//     available = json['available'];
//     userPrice = json['user_price'];
//     secUserPrice = json['sec_user_price'];
//     secCompanyPrice = json['sec_company_price'];
//     companyPrice = json['company_price'];
//     thPartyApiId = json['th_party_api_id'];
//     requirePlayerNumber = json['require_player_number'];
//     image = json['image'];
//     if (json['product_additional_services'] != null) {
//       productAdditionalServices = <ProductAdditionalServices>[];
//       json['product_additional_services'].forEach((v) {
//         productAdditionalServices!.add(ProductAdditionalServices.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['note'] = note;
//     data['number'] = number;
//     data['minimum_qut'] = minimumQut;
//     data['minimum_qut_note'] = minimumQutNote;
//     data['available'] = available;
//     data['user_price'] = userPrice;
//     data['sec_user_price'] = secUserPrice;
//     data['sec_company_price'] = secCompanyPrice;
//     data['company_price'] = companyPrice;
//     data['th_party_api_id'] = thPartyApiId;
//     data['require_player_number'] = requirePlayerNumber;
//     data['image'] = image;
//     if (productAdditionalServices != null) {
//       data['product_additional_services'] =
//           productAdditionalServices!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ProductAdditionalServices {
//   int? id;
//   String? type;
//   double? userPrice;
//   double? companyPrice;
//   String? note;
//   int? minimumQut;
//   String? minimumQutNote;

//   ProductAdditionalServices(
//       {this.id,
//       this.type,
//       this.userPrice,
//       this.companyPrice,
//       this.note,
//       this.minimumQut,
//       this.minimumQutNote});

//   ProductAdditionalServices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     userPrice = json['user_price'];
//     companyPrice = json['company_price'];
//     note = json['note'];
//     minimumQut = json['minimum_qut'];
//     minimumQutNote = json['minimum_qut_note'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['type'] = type;
//     data['user_price'] = userPrice;
//     data['company_price'] = companyPrice;
//     data['note'] = note;
//     data['minimum_qut'] = minimumQut;
//     data['minimum_qut_note'] = minimumQutNote;
//     return data;
//   }
// }

// class Links {
//   String? url;
//   String? label;
//   bool? active;

//   Links({this.url, this.label, this.active});

//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['url'] = url;
//     data['label'] = label;
//     data['active'] = active;
//     return data;
//   }
// }
