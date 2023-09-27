# Chapa Unofficial Flutter Package

The `chapa_unofficial` package is a Flutter library that provides integration with the Chapa payment gateway. It offers a convenient way to initialize payments and verify payment status within Flutter applications.

## Features
  + Initialize payment process
  + Verify payment status
  + In-app payment integration (WebView)
  + Generate transaction reference


## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
   chapa_unofficial: ^0.0.2
      
```
## Device Compatibility
```
While it is not mandatory, we strongly advise minimizing the use of emulators when working with our package. Emulators may introduce unforeseen errors or discrepancies that can affect the package's performance and behavior.
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
  // setup chapa 
  Chapa.configure(privateKey: "CHASECK_TEST-HlZh7Xo8vNvT2jm6j08OzcnFnB63Yauf");
  runApp(const MyApp());
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
      txRef: 'GENERATED_TRANSACTION_REFERENCE',
    );

 }
```
   3.1: 
  ```dart
     String? paymentUrl = await Chapa.getInstance.startPayment(
        enableInAppPayment: false,
        amount: '1000',
        currency: 'ETB',
        txRef: 'GENERATED_TRANSACTION_REFERENCE',
      );
  ```
  In this example, the startPayment method is called with the necessary parameters:
  #### + Required Arguments

   + `amount (String)`: The amount of the payment.

   + `currency (String)`: The currency of the payment.

  ### + Optional Arguments
   + `txRef (String)`: The transaction reference for the payment. if not passed, it will generate default txRef with prefix 'test'

   + `context (BuildContext)`: The BuildContext used for navigation. (Required if enableInAppPayment is set to true).
  
   + `enableInAppPayment (bool):` Flag to determine whether to use in-app payment or not. Default is true. If set to true, you are required to pass your context.

   + `onInAppPaymentSuccess (Function)`: Callback function invoked when in-app payment is successful. Receives a success message as a parameter.

   + `onInAppPaymentError (Function)`: Callback function invoked when there is an error during in-app payment. Receives an error message as a parameter.

   + `email (String)`: The email address associated with the payment.

   + `firstName (String)`: The first name of the payer.

   + `lastName (String)`: The last name of the payer.

   + `title (String)`: The title or name of the payment.

   + `description (String)`: Additional description or details about the payment.

   + `phoneNumber (String)`: The phone number associated with the payment.

   + `callbackUrl (String)`: The callback URL for handling payment callbacks or notifications.

   + `returnUrl (String)`: The return URL for redirecting after payment completion.

   ### `Note`: You can customize the payment options based on your requirements.

4. To verify the payment status, use the verifyPayment method:

```dart
 Future<void> verify()async {
Map<String, dynamic> verificationResult = await Chapa.getInstance.verifyPayment(
  txRef: 'GENERATED_TRANSACTION_REFERENCE',
);

 }
```
## Transaction Reference Generator
The `TxRefRandomGenerator` class is used for generating transaction references. This class generates random transaction references using UUID so there won't be any problem but it is possible for a coincidence to occur where two UUIDs match, the probability of this happening is extremely low. This is because UUIDs are designed to be unique and generated using a cryptographically secure random number generator, which makes it highly unlikely for two UUIDs to match.
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
## Documentation
For more details on how to use the Chapa, check out the API documentation. [API Documentation](https://developer.chapa.co/docs/)

## Contributing
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.
