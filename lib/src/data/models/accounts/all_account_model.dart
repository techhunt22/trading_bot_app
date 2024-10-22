// To parse this JSON data, do
//
//     final allAccountModel = allAccountModelFromJson(jsonString);

import 'dart:convert';

List<AllAccountModel> allAccountModelFromJson(String str) => List<AllAccountModel>.from(json.decode(str).map((x) => AllAccountModel.fromJson(x)));

String allAccountModelToJson(List<AllAccountModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllAccountModel {
  String id;
  String accountName;
  String exchangeId;
  String apiKey;
  String secretKey;
  String passphrase;
  String telegramUserId;

  AllAccountModel({
    required this.id,
    required this.accountName,
    required this.exchangeId,
    required this.apiKey,
    required this.secretKey,
    required this.passphrase,
    required this.telegramUserId,
  });

  factory AllAccountModel.fromJson(Map<String, dynamic> json) => AllAccountModel(
    id: json["_id"],
    accountName: json["accountName"],
    exchangeId: json["exchangeId"],
    apiKey: json["apiKey"],
    secretKey: json["secretKey"],
    passphrase: json["passphrase"],
    telegramUserId: json["telegramUserId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountName": accountName,
    "exchangeId": exchangeId,
    "apiKey": apiKey,
    "secretKey": secretKey,
    "passphrase": passphrase,
    "telegramUserId": telegramUserId,
  };
}
