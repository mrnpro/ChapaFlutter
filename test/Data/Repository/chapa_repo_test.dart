import 'dart:convert';

import 'package:chapa_unofficial/Core/Exceptions/ServerException/server_exception.dart';
import 'package:chapa_unofficial/Data/DataSource/RemoteDataSource/chapa_remote_data_source.dart';
import 'package:chapa_unofficial/Data/Model/authorization_model.dart';
import 'package:chapa_unofficial/Data/Model/chapa_initializer_model.dart';
import 'package:chapa_unofficial/Data/Repository/chapa_repo_impl.dart';
import 'package:chapa_unofficial/Domain/Entities/authorization_entity.dart';
import 'package:chapa_unofficial/Domain/Entities/chapa_initializer_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../Fixtures/fixture_reader.dart';
import 'chapa_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ChapaRemoteDataSource>()])
void main() {
  late ChapaRemoteDataSource mockRemoteDataSource;
  late ChapaRepoImpl sut;
  setUp(() {
    mockRemoteDataSource = MockChapaRemoteDataSource();
    sut = ChapaRepoImpl(mockRemoteDataSource);
  });
  const data = ChapaIntializerEntity(
    amount: "100",
    currency: "ETB",
    txRef: "txRef",
  );
  const authorization = AuthorizationEntity("authKeyHere");

  group("test every possible cases in the repo initialization ", () {
    test("should give checkout url with no exception ", () async {
      when(mockRemoteDataSource.postRequestInitialize(
              data: ChapaIntializerModel.fromEntity(data).toJson(),
              privateKey:
                  AuthorizationModel.fromEntity(authorization).toJson()))
          .thenAnswer(
              (_) async => json.decode(fixture('init_response_success.json')));

      final result = await sut.initialize(data, authorization);

      expect(result.$1, isNotNull);
      expect(result.$1, isA<String>());
      expect(result.$2, isNull);
    });

    test("should give exception", () async {
      when(mockRemoteDataSource.postRequestInitialize(
              data: ChapaIntializerModel.fromEntity(data).toJson(),
              privateKey:
                  AuthorizationModel.fromEntity(authorization).toJson()))
          .thenAnswer((realInvocation) async => throw const ServerException());
      final result = await sut.initialize(data, authorization);
      // if there is exception the data we need must be null
      expect(result.$1, isNull);
      // and the next parameter should not be null
      expect(result.$2, isNotNull);
    });
  });
  group("test every case while verifying the transaction ", () {
    test("should receive a success json while verifying", () async {
      when(mockRemoteDataSource.getRequestVerify(
              txRef: data.txRef,
              privateKey:
                  AuthorizationModel.fromEntity(authorization).toJson()))
          .thenAnswer((realInvocation) async =>
              json.decode(fixture('verification_success_response.json')));

      //fire
      final result = await sut.verify(data.txRef, authorization);

      expect(result.$1,
          equals(json.decode(fixture('verification_success_response.json'))));
      expect(result.$2, isNull);
    });
    test("should give exception if something go wong while verifying ",
        () async {
      when(mockRemoteDataSource.getRequestVerify(
              txRef: data.txRef,
              privateKey:
                  AuthorizationModel.fromEntity(authorization).toJson()))
          .thenAnswer((realInvocation) async => throw const ServerException());
      final result = await sut.verify(data.txRef, authorization);
      expect(result.$1, isNull);
      expect(result.$2, isNotNull);
      expect(result.$2, const ServerException());
    });
  });
}
