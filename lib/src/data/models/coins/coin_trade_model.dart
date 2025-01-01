
import 'dart:convert';

CoinTradeModel coinTradeModelFromJson(String str) => CoinTradeModel.fromJson(json.decode(str));

String coinTradeModelToJson(CoinTradeModel data) => json.encode(data.toJson());

class CoinTradeModel {
  String status;
  String message;
  Data data;

  CoinTradeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CoinTradeModel.fromJson(Map<String, dynamic> json) => CoinTradeModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Order order;
  DateTime timestamp;

  Data({
    required this.order,
    required this.timestamp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: Order.fromJson(json["order"]),
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "order": order.toJson(),
    "timestamp": timestamp.toIso8601String(),
  };
}

class Order {
  int orderId;
  String symbol;
  String quantity;
  String price;
  String status;
  String type;
  String side;
  int timestamp;

  Order({
    required this.orderId,
    required this.symbol,
    required this.quantity,
    required this.price,
    required this.status,
    required this.type,
    required this.side,
    required this.timestamp,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["orderId"],
    symbol: json["symbol"],
    quantity: json["quantity"],
    price: json["price"],
    status: json["status"],
    type: json["type"],
    side: json["side"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "symbol": symbol,
    "quantity": quantity,
    "price": price,
    "status": status,
    "type": type,
    "side": side,
    "timestamp": timestamp,
  };
}
