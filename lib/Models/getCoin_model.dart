
class GetCoinModel {
  GetCoinModel({
    this.success,
    this.orders,
  });

  bool? success;
  List<Order>? orders;

  factory GetCoinModel.fromJson(Map<String, dynamic> json) => GetCoinModel(
    success: json["success"],
    orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    this.id,
    this.users,
    this.orderId,
    this.price,
    this.coin,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? users;
  String? orderId;
  int? price;
  int? coin;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["_id"],
    users: json["users"],
    orderId: json["order_id"] == null ? null : json["order_id"],
    price: json["price"],
    coin: json["coin"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users,
    "order_id": orderId == null ? null : orderId,
    "price": price,
    "coin": coin,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}
