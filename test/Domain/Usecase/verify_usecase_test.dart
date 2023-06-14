import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:chapa_unofficial/src/Domain/Entities/authorization_entity.dart';
import 'package:chapa_unofficial/src/Domain/Repository/chapa_repo.dart';
import 'package:chapa_unofficial/src/Domain/Usecase/verify_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'verify_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ChapaRepository>()])
void main() {
  late ChapaRepository mockChapaRepo;
  late VerifyUsecase sut;

  setUp(() {
    mockChapaRepo = MockChapaRepository();
    sut = VerifyUsecase(mockChapaRepo);
  });
  const authorization = AuthorizationEntity("authKeyHere");
  group("test verification cases", () {
    String txRef = "thisIsMyUniqueTxRef";
    Map<String, dynamic> verificationMsg = {};
    test("should verification success message", () async {
      when(mockChapaRepo.verify(txRef, authorization))
          .thenAnswer((realInvocation) async => (verificationMsg, null));

      final (msg, _) = await sut(
        authorizationEntity: authorization,
        txRef: txRef,
      );
      expect(msg, isA<Map<String, dynamic>>());
      expect(msg, verificationMsg);
      verify(mockChapaRepo.verify(txRef, authorization));
      verifyNoMoreInteractions(mockChapaRepo);
    });
    test("should give exeption ", () async {
      when(mockChapaRepo.verify(txRef, authorization)).thenAnswer(
          (realInvocation) async => (null, const ServerException()));
      final (_, exception) =
          await sut(authorizationEntity: authorization, txRef: txRef);
      expect(exception, isA<ChapaException>());
      expect(exception, const ServerException());
      verify(mockChapaRepo.verify(txRef, authorization));
      verifyNoMoreInteractions(mockChapaRepo);
    });
  });
}
