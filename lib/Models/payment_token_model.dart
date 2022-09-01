class PaymentTokenModel {
  PaymentTokenModel({
    this.status,
    this.message,
    this.cfToken,
  });

  String? status;
  String? message;
  String? cfToken;

  factory PaymentTokenModel.fromJson(Map<String, dynamic> json) => PaymentTokenModel(
    status: json["status"],
    message: json["message"],
    cfToken: json["cftoken"] ??'',
  );
}
