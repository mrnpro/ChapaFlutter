import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../chapa_unofficial.dart';
import 'Core/http_config.dart';
import 'Core/type_definitions.dart';
import 'Data/DataSource/RemoteDataSource/chapa_remote_data_source.dart';
import 'Data/DataSource/RemoteDataSource/chapa_remote_data_source_impl.dart';

import 'Data/Repository/chapa_repo_impl.dart';
import 'Domain/Entities/authorization_entity.dart';
import 'Domain/Entities/chapa_initializer_entity.dart';

import 'Domain/Repository/chapa_repo.dart';
import 'Domain/Usecase/intialize_usecase.dart';
import 'Domain/Usecase/verify_usecase.dart';
import 'chapa_webview.dart';

/// The Chapa class represents a configuration for a private key and ensures
/// that only a single instance of Chapa is created.
class Chapa {
  final IntializeUsecase _initilizeUsecase;
  final VerifyUsecase _verifyUsecase;
  static Chapa? _instance;
  static String? _privateKey;
  static late Dio _dio;
  static late ChapaRepository _chapaRepository;
  static late ChapaRemoteDataSource _chapaRemoteDataSource;

  /// Private constructor for Chapa.
  /// Use the [configure] factory method to create an instance of Chapa.
  Chapa._internal(this._initilizeUsecase, this._verifyUsecase);

  /// Returns the singleton instance of Chapa.
  static Chapa get getInstance {
    if (_instance == null) {
      throw const AuthException(
          msg:
              'Please configure the API key before getting chapa instance.Please refer to the documentation: [https://pub.dev/packages/chapa_unofficial]');
    }
    return _instance!;
  }

  /// Sets up the Chapa singleton instance and other dependenciy
  /// injections with the provided [privateKey]
  static Chapa _setup(String privateKey) {
    /// setup private key .
    _privateKey = privateKey;

    /// intialize dio
    _dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: HttpConfig.chapaBaseUrl,
      ),
    );

    /// inject the data source
    _chapaRemoteDataSource = ChapaRemoteDataSourceImpl(_dio);

    /// inject the repository
    ///
    _chapaRepository = ChapaRepoImpl(_chapaRemoteDataSource);
    return Chapa._internal(
        IntializeUsecase(_chapaRepository), VerifyUsecase(_chapaRepository));
  }

  /// Configures the Chapa singleton instance with the provided [privateKey].
  /// If the instance has already been configured, it returns the existing instance.
  factory Chapa.configure({required String privateKey}) {
    _instance ??= _setup(privateKey);
    return _instance!;
  }

  /// Starts the payment process.
  ///
  /// The [context] parameter is required if [enableInAppPayment] is set to true. It represents the BuildContext used for navigation.
  /// The [enableInAppPayment] flag determines whether to use in-app payment or not . and by default it is set to true . Note that if it is set to true ,
  ///  you are required to pass your context  .
  /// The [onInAppPaymentSuccess] callback is invoked when in-app payment is successful and receives a success message as a parameter.
  /// The [onInAppPaymentError] callback is invoked when there is an error during in-app payment and receives an error message as a parameter.
  /// The [amount], [currency], and [txRef] parameters are required for the payment process.
  /// The [email], [firstName], [lastName], [title], [description], [phoneNumber], [callbackUrl], and [returnUrl] parameters are optional.

  Future<String?> startPayment({
    BuildContext? context,
    bool enableInAppPayment = true,
    Function(
      String successMsg,
    )? onInAppPaymentSuccess,
    Function(
      String errorMsg,
    )? onInAppPaymentError,
    required String amount,
    required String currency,
    String? txRef,
    String? email,
    String? firstName,
    String? lastName,
    String? title,
    String? description,
    String? phoneNumber,
    String? callbackUrl,
    String? returnUrl,
  }) async {
    // validate the private key
    if (_privateKey == null) {
      throw const AuthException(
          msg:
              'Please configure the API key before starting the payment. Refer to the documentation: [https://pub.dev/packages/chapa_unofficial]');
    }

    // intialize on the server

    final result = await _initilizeUsecase.call(
        chapaIntializer: ChapaIntializerEntity(
            amount: amount,
            currency: currency,
            /**
       If the user does not provide the transaction reference (txRef), 
       the package will continue to function by generating a transaction reference with the prefix "test-". 
       This ensures that even without user input, the program can proceed smoothly.
       */
            txRef: txRef ?? TxRefRandomGenerator.generate(),
            callbackUrl: callbackUrl,
            description: description,
            email: email,
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber,
            returnUrl: returnUrl,
            title: title),
        authorizationEntity: AuthorizationEntity(_privateKey!));

    /// handle if there is exception
    if (result.$2 != null) {
      throw result.$2!;
    }

    ///// check if the user wants in app payment
    if (enableInAppPayment) {
      //validate if the build context is passed
      if (context == null) {
        throw Exception(
            "To use 'InAppPayment' ,you are required to pass context or set 'enableInAppPayment' to false");
      }

      // fire  the WeView here
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewChapa(
                    chapaCheckoutUrl: result.$1!,
                    onInAppPaymentError: onInAppPaymentError,
                    onInAppPaymentSuccess: onInAppPaymentSuccess,
                  )));
      return null;
    }

    return result.$1;
  }

  /// This method is used to verify a payment by calling the corresponding use case.
  /// It takes a required parameter, [txRef], which is the transaction reference.
  /// The method returns a JSON object (Map<String, dynamic>) containing the verification result.
  ///
  /// Throws an exception if there is an error during the verification process.

  FutureJsonType verifyPayment({required String txRef}) async {
    final result = await _verifyUsecase.call(
        txRef: txRef, authorizationEntity: AuthorizationEntity(_privateKey!));

    /// handle exceptions
    ///
    if (result.$2 != null) {
      throw result.$2!;
    }

    /// return the json data to the user
    ///
    return result.$1!;
  }
}
