class DepositInformationModel {
  Data? data;
  int? code;

  DepositInformationModel({this.data, this.code});

  DepositInformationModel.fromJson(Map<String, dynamic> json) {
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
  String? usdtTaxPercentage;
  String? usdtText;
  String? whishMoneyTaxPercentage;
  String? whishMoneyText;

  Data(
      {this.usdtTaxPercentage,
      this.usdtText,
      this.whishMoneyTaxPercentage,
      this.whishMoneyText});

  Data.fromJson(Map<String, dynamic> json) {
    usdtTaxPercentage = json['usdt_tax_percentage'];
    usdtText = json['usdt_text'];
    whishMoneyTaxPercentage = json['whish_money_tax_percentage'];
    whishMoneyText = json['whish_money_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usdt_tax_percentage'] = usdtTaxPercentage;
    data['usdt_text'] = usdtText;
    data['whish_money_tax_percentage'] = whishMoneyTaxPercentage;
    data['whish_money_text'] = whishMoneyText;
    return data;
  }
}
