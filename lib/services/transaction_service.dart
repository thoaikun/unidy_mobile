import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/transaction_model.dart';
import 'package:unidy_mobile/services/base_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';

class TransactionService extends Service {
  HttpClient httpClient = GetIt.instance<HttpClient>();

  Future<MomoTransaction> createMomoTransaction(Map<String, int> payload) async {
      try {
        Response response = await httpClient.post('api/v1/donation', jsonEncode(payload));
        switch (response.statusCode) {
          case 200:
            return momoTransactionFromJson(utf8.decode(response.bodyBytes));
          case 400:
            throw ResponseException(value: 'Dữ liệu không hợp lệ', code: ExceptionErrorCode.invalidAmountOfMoney);
          case 403:
            catchForbidden();
            throw ResponseException(value: 'Bạn không có quyền phù hợp', code: ExceptionErrorCode.invalidToken);
          default:
            throw Exception(['Hệ thống đang bận, vui lòng thử lại sau']);
        }
      }
      catch (error) {
        rethrow;
    }
  }

  Future<void> getTransactionHistory() async {
    throw UnimplementedError();
  }

  Future<void> getTransactionDetail(String transactionId) async {
    throw UnimplementedError();
  }
}

