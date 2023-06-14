import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:chapa_unofficial/src/Domain/Entities/authorization_entity.dart';
import 'package:chapa_unofficial/src/Domain/Entities/chapa_initializer_entity.dart';
import 'package:chapa_unofficial/src/Domain/Repository/chapa_repo.dart';
import 'package:chapa_unofficial/src/Domain/Usecase/intialize_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'initialize_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ChapaRepository>()])
late ChapaRepository mockChapaRepo;
late IntializeUsecase sut;
void main() {
  setUp(() => {
        mockChapaRepo = MockChapaRepository(),
        sut = IntializeUsecase(mockChapaRepo)
      });
  const data = ChapaIntializerEntity(
    amount: "100",
    currency: "ETB",
    txRef: "txRef",
  );
  const authorization = AuthorizationEntity("authKeyHere");
  String checkoutUrl = "https://checkout.chapa.co/checkout/payment/QX91BF";
  group("initialize different case test ", () {
    test("should give checkout url", () async {
      //setup
      when(mockChapaRepo.initialize(data, authorization))
          .thenAnswer((realInvocation) async => (checkoutUrl, null));
      final (String? result, _) =
          await sut(authorizationEntity: authorization, chapaIntializer: data);
      expect(checkoutUrl, result);
      verify(mockChapaRepo.initialize(data, authorization));
      verifyNoMoreInteractions(mockChapaRepo);
    });

    test("should give Exception", () async {
      when(mockChapaRepo.initialize(data, authorization)).thenAnswer(
          (realInvocation) async => (null, const ServerException()));

      final (_, ChapaException? exception) =
          await sut(authorizationEntity: authorization, chapaIntializer: data);

      expect(exception, const ServerException());
    });
  });
}
