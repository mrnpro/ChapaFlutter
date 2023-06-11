# Chapa Unofficial Flutter Package

The `chapa_unofficial` package is a Flutter library that provides integration with the Chapa payment gateway. It offers a convenient way to initialize payments and verify payment status within Flutter applications.

## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
#   chapa_unofficial: <version>
```

## Usage

To use the `chapa_unofficial` package, follow these steps:

1. Import the package in your Dart file:

```dart
import 'package:chapa_unofficial/chapa_unofficial.dart';
```

2. Configure Chapa by calling the configure method with your private key:

```dart
Chapa.configure(privateKey: 'YOUR_PRIVATE_KEY');
```
3. Initialize a payment using the startPayment method:
```dart 
String? paymentUrl = await Chapa.getInstance.startPayment({
    context:context,
    onInAppPaymentSuccess:(successMsg){
        // handle success events
    },
    onInAppPaymentError:(errorMsg){
        //handle error
    },
  amount: '1000',
  currency: 'USD',
  txRef: 'YOUR_TRANSACTION_REFERENCE',
});
```
Note: You can customize the payment options based on your requirements.

4. To verify the payment status, use the verifyPayment method:

```dart
Map<String, dynamic> verificationResult = await Chapa.getInstance.verifyPayment({
  txRef: 'YOUR_TRANSACTION_REFERENCE',
});
```
