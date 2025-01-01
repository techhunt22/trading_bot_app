// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  String message;
  Account account;

  AccountModel({
    required this.message,
    required this.account,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    message: json["message"],
    account: Account.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "account": account.toJson(),
  };
}

class Account {
  String id;
  String accountName;
  String exchangeId;
  String apiKey;
  String secretKey;
  int v;

  Account({
    required this.id,
    required this.accountName,
    required this.exchangeId,
    required this.apiKey,
    required this.secretKey,
    required this.v,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["_id"],
    accountName: json["accountName"],
    exchangeId: json["exchangeId"],
    apiKey: json["apiKey"],
    secretKey: json["secretKey"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "accountName": accountName,
    "exchangeId": exchangeId,
    "apiKey": apiKey,
    "secretKey": secretKey,
    "__v": v,
  };
}
