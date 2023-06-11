import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';

/// A widget that displays a WebView for Chapa payment checkout.
class WebViewChapa extends StatefulWidget {
  const WebViewChapa({
    Key? key,
    required this.chapaCheckoutUrl,
    required this.onInAppPaymentSuccess,
    required this.onInAppPaymentError,
  }) : super(key: key);

  final String chapaCheckoutUrl;
  final Function(String successMsg)? onInAppPaymentSuccess;
  final Function(String errorMsg)? onInAppPaymentError;

  @override
  State<WebViewChapa> createState() => _WebViewChapaState();
}

class _WebViewChapaState extends State<WebViewChapa> {
  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest:
                  URLRequest(url: Uri.parse(widget.chapaCheckoutUrl)),
              onWebViewCreated: (controller) {
                setState(() {
                  webViewController = controller;
                });
                controller.addJavaScriptHandler(
                  handlerName: "buttonState",
                  callback: (args) async {
                    webViewController = controller;

                    if (args[2][1] == 'CancelbuttonClicked') {
                      Navigator.pop(context);
                      widget.onInAppPaymentError?.call('Payment cancelled');
                    }

                    return args.reduce((curr, next) => next);
                  },
                );
              },
              onUpdateVisitedHistory: (InAppWebViewController controller,
                  Uri? uri, androidIsReload) async {
                // Error
                controller.addJavaScriptHandler(
                  handlerName: "handlerFooWithArgs",
                  callback: (args) async {
                    webViewController = controller;
                    if (args[2][1] == 'failed') {
                      Navigator.pop(context);

                      if (widget.onInAppPaymentError != null) {
                        widget.onInAppPaymentError!.call('Payment failed');
                      }
                    }

                    return args.reduce((curr, next) => next);
                  },
                );
                controller.addJavaScriptHandler(
                  handlerName: "buttonState",
                  callback: (args) async {
                    webViewController = controller;

                    if (args[2][1] == 'CancelbuttonClicked') {
                      Navigator.pop(context);
                      if (widget.onInAppPaymentError != null) {
                        widget.onInAppPaymentError!.call('Payment cancelled');
                      }
                    }

                    return args.reduce((curr, next) => next);
                  },
                );

                // Success
                handleSuccess(uri);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Handles the success case when the payment is completed.
  void handleSuccess(Uri? uri) {
    if (uri.toString().contains('checkout/test-payment-receipt/') ||
        uri.toString().contains('checkout/payment-receipt/')) {
      Navigator.pop(context);
      // Payment successful
      widget.onInAppPaymentSuccess?.call('Payment was successful');
    }

    if (uri.toString() == 'https://chapa.co') {
      Navigator.pop(context);

      if (widget.onInAppPaymentSuccess != null) {
        widget.onInAppPaymentSuccess!.call('Payment was successful');
      }
    }
  }
}
