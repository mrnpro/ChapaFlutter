import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test TxRefRandomGenerator with possible cases ', () {
    test('generated transaction should be the same with the stored one', () {
      final generatedRef = TxRefRandomGenerator.generate();
      expect(generatedRef, equals(TxRefRandomGenerator.gettxRef));
    });
  });
}
