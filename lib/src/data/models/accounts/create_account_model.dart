// To parse this JSON data, do
//
//     final createAccountModel = createAccountModelFromJson(jsonString);

import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) => CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) => json.encode(data.toJson());

class CreateAccountModel {
  String message;
  Account account;

  CreateAccountModel({
    required this.message,
    required this.account,
  });

  factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
    message: json["message"],
    account: Account.fromJson(json["account"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "account": account.toJson(),
  };
}

class Account {
  String accountName;
  String exchangeId;
  String apiKey;
  String secretKey;
  String passphrase;
  String telegramUserId;
  String id;
  int v;

  Account({
    required this.accountName,
    required this.exchangeId,
    required this.apiKey,
    required this.secretKey,
    required this.passphrase,
    required this.telegramUserId,
    required this.id,
    required this.v,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    accountName: json["accountName"],
    exchangeId: json["exchangeId"],
    apiKey: json["apiKey"],
    secretKey: json["secretKey"],
    passphrase: json["passphrase"],
    telegramUserId: json["telegramUserId"],
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "accountName": accountName,
    "exchangeId": exchangeId,
    "apiKey": apiKey,
    "secretKey": secretKey,
    "passphrase": passphrase,
    "telegramUserId": telegramUserId,
    "_id": id,
    "__v": v,
  };
}
