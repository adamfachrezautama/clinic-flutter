import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clinicapp/core/extensions/build_context_ext.dart';
import 'package:flutter_clinicapp/presentation/chat/blocs/xendit_callback/xendit_callback_bloc.dart';
import 'package:flutter_clinicapp/presentation/chat/dialogs/payment_success_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PaymentUrlPage extends StatefulWidget {
  const PaymentUrlPage({
    super.key,
    required this.invoiceUrl,
    required this.orderId,
  });
  final String invoiceUrl;
  final String orderId;

  @override
  State<PaymentUrlPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentUrlPage> {
  late final WebViewController _controller;
  //late final Timer timer;
  bool isLoading = false;

  Future<void> _handlePaymentSuccess() async {
    showDialog(
        context: context, builder: (context) => const PaymentSuccessDialog());

    // await Future.delayed(const Duration(seconds: 3));
    // if (mounted) {
    //   context.popToRoot();
    //   // context.push(OrderStatusAfterPayment(
    //   //   orderData: widget.orderData,
    //   // ));
    //   context.read<CheckoutBloc>().add(const CheckoutEvent.started());
    // }
  }

  Future<void> _handlePaymentFailure() async {
    context.showDialogError(
      'Pembayaran Gagal',
      'Ops. Terjadi kesalahan, mohon ulangi sesaat lagi ya, Sob.',
    );

    if (mounted) {
      context.popToRoot();
    }
  }

  @override
  void initState() {
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params);
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            debugPrint('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('request: ${request.url} | OrderId: ${widget.orderId}');
            if (request.url.contains('flutter/success')) {
              context.read<XenditCallbackBloc>().add(
                  XenditCallbackEvent.callback(
                      'order-${widget.orderId}', 'Success'));
              _handlePaymentSuccess();
              return NavigationDecision.prevent;
            } else if (request.url.contains('flutter/failure')) {
              _handlePaymentFailure();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('url change: ${change.url}');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.invoiceUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
