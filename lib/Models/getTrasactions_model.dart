
class GetTransactionsModel {
  GetTransactionsModel({
    this.success,
    this.transactions,
  });

  bool? success;
  List<Transaction>? transactions;

  factory GetTransactionsModel.fromJson(Map<String, dynamic> json) => GetTransactionsModel(
    success: json["success"],
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
  };
}

class Transaction {
  Transaction({
    this.id,
    this.users,
    this.from,
    this.transaction,
    this.received,
    this.status,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? users;
  From? from;
  String? transaction;
  bool? received;
  String? status;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["_id"],
    users: json["users"],
    from: From.fromJson(json["from"]),
    transaction: json["transaction"],
    received: json["received"],
    status: json["status"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users,
    "from": from,
    "transaction": transaction,
    "received": received,
    "status": status,
    "price": price,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "__v": v,
  };
}

class From {
  From({
    this.id,
    this.name,
    this.profile,
  });

  String? id;
  String? name;
  String? profile;

  factory From.fromJson(Map<String, dynamic> json) => From(
    id: json["_id"],
    name: json["name"],
    profile: json["profile"] == null ? null : json["profile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profile": profile == null ? null : profile,
  };
}
