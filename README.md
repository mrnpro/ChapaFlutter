# Chapa Unofficial Flutter Package

The `chapa_unofficial` package is a Flutter library that provides integration with the Chapa payment gateway. It offers a convenient way to initialize payments and verify payment status within Flutter applications.

## Features
  + Initialize payment process
  + Verify payment status
  + In-app payment integration (WebView)


## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
   chapa_unofficial:
      git: https://github.com/mrnpro/ChapaFlutter.git
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
 `the best place to configure chapa is inside main method` as an example shown below:
```dart

void main() {
  runApp(const MyApp());

  // setup chapa 
  Chapa.configure(privateKey: "CHASECK_TEST-HlZh7Xo8vNvT2jm6j08OzcnFnB63Yauf");
}


```
 + `Note`: The Chapa class follows the Singleton pattern, which ensures that only a single instance of Chapa is created and used throughout your application. You can access the Chapa instance using the Chapa.getInstance getter.
 
3. Initialize a payment using the startPayment method:
```dart 
 Future<void> pay() async{
   String? paymentUrl = await Chapa.getInstance.startPayment(
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
    );

 }
```
   3.1: 
  ```dart
     String? paymentUrl = await Chapa.getInstance.startPayment(
        context: context,
        enableInAppPayment: false,
        onInAppPaymentSuccess: (successMsg) {
          // Handle success events
        },
        onInAppPaymentError: (errorMsg) {
          // Handle error
        },
        amount: '1000',
        currency: 'ETB',
        txRef: 'YOUR_TRANSACTION_REFERENCE',
      );
  ```
  In this example, the startPayment method is called with the necessary parameters:

`context`: The BuildContext used for navigation (required if enableInAppPayment is true).

`enableInAppPayment`: Determines whether to use in-app payment or not. Set it to false to get the payment URL directly.

`onInAppPaymentSuccess`: A callback function invoked when in-app payment is successful.

`onInAppPaymentError`: A callback function invoked when there is an error during in-app payment.

`amount`: The payment amount.

`currency`: The currency of the payment.

`txRef`: The transaction reference.
   ### `Note`: You can customize the payment options based on your requirements.

4. To verify the payment status, use the verifyPayment method:

```dart
 Future<void> verify()async {
Map<String, dynamic> verificationResult = await Chapa.getInstance.verifyPayment(
  txRef: 'YOUR_TRANSACTION_REFERENCE',
);

 }
```
## Transaction Reference Generator
The `TxRefRandomGenerator` class is used for generating transaction references for testing purposes. Please note that this class should NOT be used in a production environment.
### Example

```dart
Future<void> pay() async{
  // Generate a random transaction reference with a custom prefix
  String txRef = TxRefRandomGenerator.generate(prefix: 'Pharmabet');
  
  // Access the generated transaction reference
  String storedTxRef = TxRefRandomGenerator.gettxRef;
  
  // Print the generated transaction reference and the stored transaction reference
  print('Generated TxRef: $txRef');
  print('Stored TxRef: $storedTxRef');
  await Chapa.getInstance.startPayment(
        context: context,
        onInAppPaymentSuccess: (successMsg) {
          // Handle success events
        },
        onInAppPaymentError: (errorMsg) {
          // Handle error
        },
        amount: '1000',
        currency: 'ETB',
        txRef: storedTxRef,
      );
}
```

This example shows how to generate a random transaction reference with a custom prefix,   access the generated transaction reference using the gettxRef getter, and shows how you can use it in a start payment.

`Please note that the TxRefRandomGenerator class is intended for testing purposes only and should not be used in a production environment.`

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

