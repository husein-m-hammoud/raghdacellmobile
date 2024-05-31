// ignore_for_file: prefer_typing_uninitialized_variables

class ProfileModel {
  Data? data;
  int? code;

  ProfileModel({this.data, this.code});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  var username;
  var balance;
  var phoneNumber;
  var email;
  var type;
  var createdAt;
  var updatedAt;
  var deletedAt;
  var newNotificationsCount;

  Data(
      {this.id,
      this.username,
      this.balance,
      this.phoneNumber,
      this.email,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.newNotificationsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    balance = json['balance'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    newNotificationsCount = json['new_notifications_count'];
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
    data['new_notifications_count'] = newNotificationsCount;
    return data;
  }
}
