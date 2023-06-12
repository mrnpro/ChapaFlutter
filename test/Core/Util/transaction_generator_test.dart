import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test TxRefRandomGenerator with possible cases ', () {
    test('generate should generate a random transaction reference with prefix',
        () {
      const prefix = 'Pharmabet';
      final generatedRef = TxRefRandomGenerator.generate(prefix: prefix);
      expect(generatedRef, startsWith(prefix));
    });
    test('generated transaction should be the same with stored one', () {
      const prefix = 'Pharmabet';
      final generatedRef = TxRefRandomGenerator.generate(prefix: prefix);

      expect(generatedRef, equals(TxRefRandomGenerator.gettxRef));
    });

    test(
        'generate should generate a random transaction reference without prefix',
        () {
      final generatedRef = TxRefRandomGenerator.generate();
      expect(generatedRef, startsWith('test'));
    });
  });
}
