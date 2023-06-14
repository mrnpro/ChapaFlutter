import '../../Core/type_definitions.dart';
import '../../Domain/Entities/chapa_initializer_entity.dart';

/// The model class representing the Chapa initializer entity.
class ChapaIntializerModel extends ChapaIntializerEntity {
  /// Creates an instance of [ChapaIntializerModel] with the given parameters.
  ///
  /// - `amount`: The amount for the Chapa initializer.
  /// - `currency`: The currency for the Chapa initializer.
  /// - `txRef`: The transaction reference for the Chapa initializer.
  /// - `callbackUrl`: The callback URL for the Chapa initializer.
  /// - `description`: The description for the Chapa initializer.
  /// - `email`: The email for the Chapa initializer.
  /// - `firstName`: The first name for the Chapa initializer.
  /// - `lastName`: The last name for the Chapa initializer.
  /// - `phoneNumber`: The phone number for the Chapa initializer.
  /// - `title`: The title for the Chapa initializer.
  /// - `returnUrl`: The return URL for the Chapa initializer.
  const ChapaIntializerModel({
    required String amount,
    required String currency,
    required String txRef,
    String? callbackUrl,
    String? description,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? title,
    String? returnUrl,
  }) : super(
          amount: amount,
          currency: currency,
          txRef: txRef,
          callbackUrl: callbackUrl,
          description: description,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          title: title,
          returnUrl: returnUrl,
        );

  /// Factory method to create a [ChapaIntializerModel] from a [ChapaIntializerEntity].
  ///
  /// - `entity`: The [ChapaIntializerEntity] to create the [ChapaIntializerModel] from.
  ///
  /// Returns an instance of [ChapaIntializerModel].
  factory ChapaIntializerModel.fromEntity(ChapaIntializerEntity entity) {
    return ChapaIntializerModel(
      amount: entity.amount,
      currency: entity.currency,
      txRef: entity.txRef,
      callbackUrl: entity.callbackUrl,
      description: entity.description,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phoneNumber: entity.phoneNumber,
      title: entity.title,
      returnUrl: entity.returnUrl,
    );
  }

  /// Converts the [ChapaIntializerModel] to a JSON object.
  ///
  /// Returns a [JsonType] object representing the JSON conversion of the [ChapaIntializerModel].
  JsonType toJson() {
    Map<String, dynamic> json = {
      "amount": super.amount,
      "currency": super.currency,
      "email": super.email,
      "first_name": super.firstName,
      "last_name": super.lastName,
      "phone_number": super.phoneNumber,
      "tx_ref": super.txRef,
      "callback_url": super.callbackUrl,
      "return_url": super.returnUrl,
      "customization[title]": super.title,
      "customization[description]": super.description,
    };

    // Remove null values from the JSON object before returning.
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
