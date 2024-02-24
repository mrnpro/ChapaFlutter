import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:chapa_unofficial/src/Domain/Usecase/intialize_usecase.dart';
import 'package:chapa_unofficial/src/Domain/Usecase/verify_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

// import 'chapa_unofficial_test.mocks.dart';

@GenerateNiceMocks([MockSpec<VerifyUsecase>(), MockSpec<IntializeUsecase>()])
void main() {
  group('test all possible cases in Chapa logic', () {
    const privateKey = 'test_private_key';
    late Chapa chapa;
    // late MockIntializeUsecase mockIntializeUsecase;
    // late MockVerifyUsecase mockVerifyUsecase;

    setUp(() {
      // mockIntializeUsecase = MockIntializeUsecase();
      // mockVerifyUsecase = MockVerifyUsecase();
      chapa = Chapa.configure(privateKey: privateKey);
    });

    test('getInstance should return the same instance', () {
      final instance1 = Chapa.getInstance;
      final instance2 = Chapa.getInstance;

      expect(instance1, isNotNull);
      expect(instance2, isNotNull);
      expect(instance1, equals(instance2));
    });

    test('configure should set up Chapa with the provided private key', () {
      final configuredChapa = Chapa.configure(privateKey: privateKey);

      expect(configuredChapa, isNotNull);
      expect(configuredChapa, equals(Chapa.getInstance));
    });

    test(
        'startPayment should throw AuthException if privateKey is not configured',
        () {
      expect(
          () => chapa.startPayment(
                amount: '10',
                currency: 'ETB',
                txRef: 'tx123',
              ),
          throwsA(isA<AuthException>()));
    });

    test(
        'verifyPayment should throw AuthException if privateKey is not configured',
        () {
      expect(() => chapa.verifyPayment(txRef: 'tx123'),
          throwsA(isA<AuthException>()));
    });
    test(
        'chapa getInstance should throw AuthException if privateKey is not configured',
        () {
      //  reset everything to test this test works
      Chapa.resetConfiguration();

      expect(() => Chapa.getInstance, throwsA(isA<AuthException>()));
    });
  });
}
