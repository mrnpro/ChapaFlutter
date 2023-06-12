import 'package:chapa_unofficial/chapa_unofficial.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());

  // setup chapa
  Chapa.configure(privateKey: "CHASECK_TEST-HlZh7Xo8vNvT2jm6j08OzcnFnB63Yauf");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  Future<void> verify() async {
    Map<String, dynamic> verificationResult =
        await Chapa.getInstance.verifyPayment(
      txRef: TxRefRandomGenerator.gettxRef,
    );
    print(verificationResult);
  }

  Future<void> pay() async {
    try {
      // Generate a random transaction reference with a custom prefix
      String txRef = TxRefRandomGenerator.generate(prefix: 'linat');

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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linat's payment"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'pay to linat416',
            ),
            TextButton(
                onPressed: () async {
                  await pay();
                },
                child: const Text("Pay")),
            TextButton(
                onPressed: () async {
                  await verify();
                },
                child: const Text("Verify")),
          ],
        ),
      ),
    );
  }
}
