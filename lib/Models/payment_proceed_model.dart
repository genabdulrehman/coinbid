
class PaymentProceedModel {
  PaymentProceedModel({
    this.txStatus,
    this.orderAmount,
    this.paymentMode,
    this.orderId,
    this.txTime,
    this.signature,
    this.txMsg,
    this.type,
    this.referenceId,
  });

  String? txStatus;
  String? orderAmount;
  String? paymentMode;
  String? orderId;
  DateTime? txTime;
  String? signature;
  String? txMsg;
  String? type;
  String? referenceId;

  factory PaymentProceedModel.fromJson(Map<dynamic, dynamic> json) => PaymentProceedModel(
    txStatus: json["txStatus"],
    orderAmount: json["orderAmount"] ??'',
    paymentMode: json["paymentMode"]??'',
    orderId: json["orderId"],
    // txTime: DateTime.parse(json["txTime"]) ?? DateTime.now(),
    signature: json["signature"] ??'',
    txMsg: json["txMsg"] ??'',
    type: json["type"] ??'',
    referenceId: json["referenceId"]??'',
  );
}
