// ignore_for_file: prefer_typing_uninitialized_variables

class ViewWalletModel {
  User? user;
  Data? data;
  int? code;

  ViewWalletModel({this.user, this.data, this.code});

  ViewWalletModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class User {
  String? username;
  String? phoneNumber;
  var currentBalance;
  var totalShipped;
  var totalSpent;

  User(
      {this.username,
      this.phoneNumber,
      this.currentBalance,
      this.totalShipped,
      this.totalSpent});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phoneNumber = json['phone_number'];
    currentBalance = json['current_balance'];
    totalShipped = json['total_shipped'];
    totalSpent = json['total_spent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['phone_number'] = phoneNumber;
    data['current_balance'] = currentBalance;
    data['total_shipped'] = totalShipped;
    data['total_spent'] = totalSpent;
    return data;
  }
}

class Data {
  int? currentPage;
  List<WalletDetails>? walletDetails;
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
      this.walletDetails,
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
      walletDetails = <WalletDetails>[];
      json['data'].forEach((v) {
        walletDetails!.add(WalletDetails.fromJson(v));
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
    if (walletDetails != null) {
      data['data'] = walletDetails!.map((v) => v.toJson()).toList();
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

class WalletDetails {
  int? id;
  String? status;
  String? name;
  var previousBalance;
  var value;
  var currentBalance;
  String? date;
  String? time;

  WalletDetails(
      {this.id,
      this.status,
      this.name,
      this.previousBalance,
      this.value,
      this.currentBalance,
      this.date,
      this.time});

  WalletDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    previousBalance = json['previous_balance'];
    value = json['value'];
    currentBalance = json['current_balance'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    data['previous_balance'] = previousBalance;
    data['value'] = value;
    data['current_balance'] = currentBalance;
    data['date'] = date;
    data['time'] = time;
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
