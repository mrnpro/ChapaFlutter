import 'package:chapa_unofficial/Data/Model/chapa_initializer_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const initializerModel = ChapaIntializerModel(
    amount: "234",
    currency: "Ethiopian",
    txRef: "unique Ref",
  );
  final testJson = {
    "amount": "234",
    "currency": "Ethiopian",
    "tx_ref": "unique Ref"
  };

  group("test possible cases in Initializer model", () {
    test(
        'should return the non-nullable fields of a model class in JSON format',
        () {
      final resultJson = initializerModel.toJson();
      expect(testJson, equals(resultJson));
    });
  });
}
