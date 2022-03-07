// To parse this JSON data, do
//
//     final homeCareCategoriesModel = homeCareCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HomeCareCategoriesModel homeCareCategoriesModelFromJson(String str) =>
    HomeCareCategoriesModel.fromJson(json.decode(str));

String homeCareCategoriesModelToJson(HomeCareCategoriesModel data) =>
    json.encode(data.toJson());

class HomeCareCategoriesModel {
  HomeCareCategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<HomeCareCategoriesData> data;

  factory HomeCareCategoriesModel.fromJson(Map<String, dynamic> json) =>
      HomeCareCategoriesModel(
        status: json["status"],
        message: json["message"],
        data: List<HomeCareCategoriesData>.from(
            json["data"].map((x) => HomeCareCategoriesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HomeCareCategoriesData {
  HomeCareCategoriesData({
    required this.serviceId,
    required this.serviceName,
    required this.image,
  });

  String serviceId;
  String serviceName;
  String image;

  factory HomeCareCategoriesData.fromJson(Map<String, dynamic> json) =>
      HomeCareCategoriesData(
        serviceId: json["Service_id"],
        serviceName: json["Service Name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Service_id": serviceId,
        "Service Name": serviceName,
        "image": image,
      };
}
