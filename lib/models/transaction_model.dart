import 'dart:convert';

MomoTransaction momoTransactionFromJson(String str) => MomoTransaction.fromJson(json.decode(str));

String momoTransactionToJson(MomoTransaction data) => json.encode(data.toJson());

class MomoTransaction {
  String partnerCode;
  String requestId;
  String orderId;
  int amount;
  int responseTime;
  String message;
  int resultCode;
  String payUrl;
  String? deeplink;
  String? qrCodeUrl;
  String? deeplinkMiniApp;
  String? transId;
  String? signature;

  MomoTransaction({
    required this.partnerCode,
    required this.requestId,
    required this.orderId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
    this.deeplink,
    this.qrCodeUrl,
    this.deeplinkMiniApp,
    this.transId,
    this.signature,
  });

  factory MomoTransaction.fromJson(Map<String, dynamic> json) => MomoTransaction(
    partnerCode: json["partnerCode"],
    requestId: json["requestId"],
    orderId: json["orderId"],
    amount: json["amount"],
    responseTime: json["responseTime"],
    message: json["message"],
    resultCode: json["resultCode"],
    payUrl: json["payUrl"],
    deeplink: json["deeplink"],
    qrCodeUrl: json["qrCodeUrl"],
    deeplinkMiniApp: json["deeplinkMiniApp"],
    transId: json["transId"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "partnerCode": partnerCode,
    "requestId": requestId,
    "orderId": orderId,
    "amount": amount,
    "responseTime": responseTime,
    "message": message,
    "resultCode": resultCode,
    "payUrl": payUrl,
    "deeplink": deeplink,
    "qrCodeUrl": qrCodeUrl,
    "deeplinkMiniApp": deeplinkMiniApp,
    "transId": transId,
    "signature": signature,
  };
}
