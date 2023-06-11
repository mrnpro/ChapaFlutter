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
  currency: 'ETB',
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
## Exceptions
The chapa_unofficial package provides several exceptions that can be thrown during the payment process. These exceptions allow you to handle specific error scenarios and provide meaningful feedback to your users. Here are the exceptions available:

`AuthException`: Thrown when there is an authentication error during the payment process. It contains a message describing the error.

`InitializationException`: Thrown when there is an issue with the `startPayment` method of the Chapa instance. It contains a message describing the error.

`NetworkException`: Thrown when there is a network-related error during the payment process. This exception can be used to handle scenarios such as connection timeouts or unavailable network.

`ServerException`: Thrown when there is an error on the server-side during the payment process. It contains a message describing the error.

`UnknownException`: Thrown when an unknown or unexpected error occurs during the payment process. This exception can be used as a fallback for handling unanticipated errors.

`VerificationException`: Thrown when there is an error during the payment verification process. It contains a message describing the error.

### Example 
 Example 1 : exceptions may occure during `startPayment`
 ```dart 
 try {
  // start Payment Code 
} on ChapaException catch (e) {
  if (e is AuthException) {
    // Handle authentication error
  } else if (e is InitializationException) {
    // Handle initialization error
  } else if (e is NetworkException) {
    // Handle network error
  } else if (e is ServerException) {
    // Handle server-side error
  } else {
    // Handle unknown error
  }
}
```
 Example 2 : exceptions may occure during `verifyPayment`  
 
```dart
 try {
  //   verification code here 
} on ChapaException catch (e) {
  if (e is AuthException) {
    // Handle authentication error
  } else if (e is NetworkException) {
    // Handle network error
  } else if (e is ServerException) {
    // Handle server-side error
  } else if (e is VerificationException) {
    // Handle payment verification error
  } else {
    // Handle unknown error 
  }
}
```
