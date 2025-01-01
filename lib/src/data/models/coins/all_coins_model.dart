// To parse this JSON data, do
//
//     final allCoinsDataModel = allCoinsDataModelFromJson(jsonString);

import 'dart:convert';

AllCoinsDataModel allCoinsDataModelFromJson(String str) => AllCoinsDataModel.fromJson(json.decode(str));

String allCoinsDataModelToJson(AllCoinsDataModel data) => json.encode(data.toJson());

class AllCoinsDataModel {
  List<String> coins;

  AllCoinsDataModel({
    required this.coins,
  });

  factory AllCoinsDataModel.fromJson(Map<String, dynamic> json) => AllCoinsDataModel(
    coins: List<String>.from(json["coins"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "coins": List<dynamic>.from(coins.map((x) => x)),
  };
}



AllCoinsUpdateModel allCoinsUpdateModelFromJson(String str) => AllCoinsUpdateModel.fromJson(json.decode(str));

String allCoinsUpdateModelToJson(AllCoinsUpdateModel data) => json.encode(data.toJson());

class AllCoinsUpdateModel {
  String message;
  List<String> listedCoins;

  AllCoinsUpdateModel({
    required this.message,
    required this.listedCoins,
  });

  factory AllCoinsUpdateModel.fromJson(Map<String, dynamic> json) => AllCoinsUpdateModel(
    message: json["message"],
    listedCoins: List<String>.from(json["listedCoins"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "listedCoins": List<dynamic>.from(listedCoins.map((x) => x)),
  };
}
