// ignore_for_file: prefer_typing_uninitialized_variables

class OrdersViewModel {
  Data? data;
  int? code;

  OrdersViewModel({this.data, this.code});

  OrdersViewModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Orders>? orders;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.orders,
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
      orders = <Orders>[];
      json['data'].forEach((v) {
        orders!.add(Orders.fromJson(v));
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
    if (orders != null) {
      data['data'] = orders!.map((v) => v.toJson()).toList();
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

class Orders {
  var id;
  var playerNumber;
  var playerName;
  var serviceType;
  var quantity;
  var socialLink;
  var walletAddress;
  var emailOrPhoneNumber;
  var password;
  var contactNumber;
  User? user;
  var productImage;
  var itemCodes;
  var productName;
  var packageName;
  var pricePerItem;
  var totalPrice;
  var status;
  var refuseReason;
  var acceptNote;
  var date;
  var time;

  Orders(
      {this.id,
      this.playerNumber,
      this.playerName,
      this.serviceType,
      this.quantity,
      this.socialLink,
      this.walletAddress,
      this.emailOrPhoneNumber,
      this.password,
      this.contactNumber,
      this.user,
      this.productImage,
      this.itemCodes,
      this.productName,
      this.packageName,
      this.pricePerItem,
      this.totalPrice,
      this.status,
      this.refuseReason,
      this.acceptNote,
      this.date,
      this.time});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerNumber = json['player_number'];
    playerName = json['player_name'];
    serviceType = json['service_type'];
    quantity = json['quantity'];
    socialLink = json['social_link'];
    walletAddress = json['wallet_address'];
    emailOrPhoneNumber = json['email_or_phone_number'];
    password = json['password'];
    contactNumber = json['contact_number'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    productImage = json['product_image'];
    itemCodes = json['item_codes'];
    productName = json['product_name'];
    packageName = json['package_name'];
    pricePerItem = json['price_per_item'];
    totalPrice = json['total_price'];
    status = json['status'];
    refuseReason = json['refuse_reason'];
    acceptNote = json['accept_note'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['player_number'] = playerNumber;
    data['player_name'] = playerName;
    data['service_type'] = serviceType;
    data['quantity'] = quantity;
    data['social_link'] = socialLink;
    data['wallet_address'] = walletAddress;
    data['email_or_phone_number'] = emailOrPhoneNumber;
    data['password'] = password;
    data['contact_number'] = contactNumber;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['product_image'] = productImage;
    data['item_codes'] = itemCodes;

    data['product_name'] = productName;
    data['package_name'] = packageName;
    data['price_per_item'] = pricePerItem;
    data['total_price'] = totalPrice;
    data['status'] = status;
    data['refuse_reason'] = refuseReason;
    data['accept_note'] = acceptNote;
    data['date'] = date;
    data['time'] = time;
    return data;
  }
}

class User {
  int? id;
  String? username;
  double? balance;
  String? phoneNumber;
  String? email;
  String? type;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  User(
      {this.id,
      this.username,
      this.balance,
      this.phoneNumber,
      this.email,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    balance = json['balance'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['balance'] = balance;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
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
