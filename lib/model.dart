// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:raghadcell/Core/Constants/app_assets.dart';
import 'package:raghadcell/Core/Constants/app_colors.dart';

class ProductModel {
  String name;
  String price;
  int productNumber;
  ProductModel({
    required this.name,
    required this.price,
    required this.productNumber,
  });
}

class CardModel {
  String name;
  String oldPrice;
  String newPrice;
  String date;
  String time;
  String image;

  CardModel({
    required this.name,
    required this.oldPrice,
    required this.newPrice,
    required this.date,
    required this.time,
    required this.image,
  });
}

// List<ProductModel> products = [
//   ProductModel(name: "Product 1", price: "5000\$", productNumber: 1),
//   ProductModel(name: "Product 2", price: "5000\$", productNumber: 2),
//   ProductModel(name: "Product 3", price: "5000\$", productNumber: 3),
//   ProductModel(name: "Product 4", price: "5000\$", productNumber: 4),
//   ProductModel(name: "Product 5", price: "5000\$", productNumber: 5)
// ];

List<CardModel> card = [
  CardModel(
      date: "28/7/2023",
      time: "07:07 PM",
      image: AppAssets.redIcon,
      name: "RAGHAD CELL",
      newPrice: "200",
      oldPrice: "500"),
  CardModel(
      date: "28/7/2023",
      time: "07:07 PM",
      image: AppAssets.greenIcon,
      name: "RAGHAD CELL",
      newPrice: "200",
      oldPrice: "500"),
  CardModel(
      date: "28/7/2023",
      time: "07:07 PM",
      image: AppAssets.greenIcon,
      name: "RAGHAD CELL",
      newPrice: "200",
      oldPrice: "500"),
  CardModel(
      date: "28/7/2023",
      time: "07:07 PM",
      image: AppAssets.redIcon,
      name: "RAGHAD CELL",
      newPrice: "200",
      oldPrice: "500"),
];

class PaymentsModel {
  String value;
  String notice;
  String date;
  String orderStatus;
  Color colorState;
  PaymentsModel({
    required this.value,
    required this.notice,
    required this.date,
    required this.orderStatus,
    required this.colorState,
  });
}

List<PaymentsModel> paymentsModel = [
  PaymentsModel(
      value: "\$400",
      notice: "",
      date: "28/7/2023  07:07 PM",
      orderStatus: "Charged",
      colorState: Colors.green),
  PaymentsModel(
      value: "\$400",
      notice: "",
      date: "28/7/2023  07:07 PM",
      orderStatus: "Waiting",
      colorState: Colors.blue),
  PaymentsModel(
      value: "\$400",
      notice: "",
      date: "28/7/2023  07:07 PM",
      orderStatus: "Waiting",
      colorState: Colors.blue),
  PaymentsModel(
      value: "\$400",
      notice: "",
      date: "28/7/2023  07:07 PM",
      orderStatus: "Charged",
      colorState: Colors.green)
];

class Requests {
  String iD;
  String date;
  String orderStatus;
  String cost;
  Color colorState;
  Requests({
    required this.iD,
    required this.date,
    required this.orderStatus,
    required this.cost,
    required this.colorState,
  });
}

List<Requests> requests = [
  Requests(
      iD: "#100180",
      date: "29/7/2023",
      orderStatus: "Completed",
      cost: "\$500",
      colorState: Colors.green),
  Requests(
      iD: "#100180",
      date: "29/7/2023",
      orderStatus: "Waiting",
      cost: "\$500",
      colorState: Colors.blue),
  Requests(
      iD: "#100180",
      date: "29/7/2023",
      orderStatus: "Canceled",
      cost: "\$500",
      colorState: AppColors.seconedaryColor)
];
