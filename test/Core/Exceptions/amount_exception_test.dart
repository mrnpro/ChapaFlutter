import 'package:chapa_unofficial/src/Core/apis.dart';
import 'package:chapa_unofficial/src/Core/http_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String> check() async {
  final dio = Dio();
  const data = {
    "amount": "300000",
    "currency": "ETB",
    "tx_ref": "test-1234"
  };

  const private = {
    "Authorization": "Bearer CHASECK_TEST-6LtxBq0mWOdlkV9CtubFe9NUhGYPv9bL",
  };

  try {
    final response = await dio.post(
        HttpConfig.chapaBaseUrl + Apis.chapaIntializeUrl,
        data: data,
        options: Options(
          headers: private
    ));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to post data');
    }
  } on DioException catch (e) {
    final response = e.response;
    if (response != null &&
        response.data != null &&
        response.data['message'] != null) {
      final message = response.data['message'];
      if (message['amount'] != null && message['amount'].isNotEmpty) {
        return message['amount'][0];
      }
    }
    throw Exception(e);
  }
}

Future<String> checkV2() async {
  final dio = Dio();
  const data = {
    "amount": "300,000",
    "currency": "ETB",
    "tx_ref": "test-1234"
  };

  const private = {
    "Authorization": "Bearer CHASECK_TEST-6LtxBq0mWOdlkV9CtubFe9NUhGYPv9bL",
  };

  try {
    final response = await dio.post(
        HttpConfig.chapaBaseUrl + Apis.chapaIntializeUrl,
        data: data,
        options: Options(
          headers: private
    ));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to post data');
    }
  } on DioException catch (e) {
    final response = e.response;
    if (response != null &&
        response.data != null &&
        response.data['message'] != null) {
      final message = response.data['message'];
      if (message['amount'] != null && message['amount'].isNotEmpty) {
        return message['amount'][0];
      }
    }
    throw Exception(e);
  }
}

void main() {
  group('test AmountException with possible cases', () {
    test('amount exception class should return maximum amount reached',
        () async {
      final error = await check();
      expect(error, 'validation.max.numeric');
    });
    test('amount exception class should return don\'t pass the amount with numeric format',
        () async {
      final error = await checkV2();
      expect(error, 'validation.numeric');
    });
  });
}
