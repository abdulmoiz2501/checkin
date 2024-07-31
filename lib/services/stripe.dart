import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StripeServices {
  StripeServices._();
  static final StripeServices _instance = StripeServices._();
  static StripeServices get instance => _instance;
  
  final isDebugMode = true;
  var isLoading = false.obs;
  
  final String _publishableKeyTest = 'pk_live_51Pfzw1RumBeUNDT0vz8WmbhnGAgUoYqNyDSmYzRaS8yC3ghhWts1d4AIEq0vBHSj5dNbYBwzdvJUFtAhnNJryj5k000e8ZvJdW';
  final String _secretKeyTest = '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';

  Future<void> initialize() async {
    Stripe.publishableKey = _publishableKeyTest;
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
    log('@initialize =====> Stripe is initialized');
  }

  String _calculate(double price) {
    double amountInCents = price * 100;
    int amountInt = amountInCents.ceil();
    return amountInt.toString();
  }
Future<void> startPurchase(
  double amount, 
  Future<void> Function(bool, String) purchaseHook,
  BuildContext context
) async {
  isLoading.value = true;
  try {
    await initialize();
    Map<String, dynamic>? paymentIntentData =
        await _getPaymentIntent(_calculate(amount), 'USD');
    if (paymentIntentData == null) {
      print('Payment Intent Error!. Payment failed, please try again.');
      return;
    }
    print("}}}}}}}}}}}}}}}}}}}}}}}}}");
    print("Payment Intent Data: $paymentIntentData");
    print("Payment intent key: ${paymentIntentData['client_secret']}");

    bool isGooglePayAvailable = await Stripe.instance.isPlatformPaySupported(
      googlePay: IsGooglePaySupportedParams(),
    );
    if (isGooglePayAvailable) {
      print("Google pay is available");
      await startGooglePay(purchaseHook, paymentIntentData['client_secret']);
    } else {
      print('Google Pay is not available on this device.');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          customerId: paymentIntentData['id'],
          applePay: Platform.isIOS ? PaymentSheetApplePay(merchantCountryCode: 'US') : null,
          googlePay: PaymentSheetGooglePay(
              merchantCountryCode: 'US',
              currencyCode: 'USD',
              testEnv: isDebugMode,
              buttonType: PlatformButtonType.googlePayMark
          ),
          style: ThemeMode.light,
          merchantDisplayName: 'My Ticket',
        ),
      ).then((val) async {
        await _showPaymentIntentSheet(purchaseHook);
      });
    }
  } catch (e, s) {
    log('@startPurchase onCatch=====> $e\n$s');
    purchaseHook.call(false, e.toString());
  } finally {
    isLoading.value = false;
  }
}

  Future<void> startGooglePay(Future<void> Function(bool, String) purchaseHook, String clientSecret) async {
    final googlePaySupported = await Stripe.instance
        .isPlatformPaySupported(googlePay: IsGooglePaySupportedParams());
    if (googlePaySupported) {
      try {
        await Stripe.instance.confirmPlatformPayPaymentIntent(
          clientSecret: clientSecret,
          confirmParams: PlatformPayConfirmParams.googlePay(
            googlePay: GooglePayParams(
              testEnv: true,
              merchantName: 'Example Merchant Name',
              merchantCountryCode: 'US',
              currencyCode: 'USD',
            ),
          ),
        );
        await purchaseHook.call(true, 'Google Pay payment successfully completed');
      } catch (e) {
        log('Error during Google Pay: $e', error: e, stackTrace: StackTrace.current);
        await purchaseHook.call(false, 'Google Pay payment failed: $e');
      }
    } else {
      log('Google Pay is not supported on this device');
      await purchaseHook.call(false, 'Google Pay is not supported on this device');
    }
  }

  Future<void> _showPaymentIntentSheet(
    Future<void> Function(bool, String message) purchaseHook
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) async {
        await purchaseHook.call(true, 'Payment Successful!');
      });
    } on StripeException catch (e) {
      await purchaseHook.call(false, e.error.message.toString());
      log('@_showPaymentIntentSheet onStripeException=====> ${e.error}');
    } catch (e) {
      await purchaseHook.call(false, e.toString());
      log('@_showPaymentIntentSheet onCatch=====> $e');
    }
  }

  Future<Map<String, dynamic>?> _getPaymentIntent(
    String amount, 
    String currency
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $_secretKeyTest',
          'Content-Type': 'application/x-www-form-urlencoded'
        }
      );
      log('Payment Intent Response: ${response.body}');
      return jsonDecode(response.body);
    } catch (err) {
      log('@_getPaymentIntentError===>${err.toString()}');
      return null;
    }
  }
  
  Future<bool> _isGooglePayAvailable() async {
    final params = IsGooglePaySupportedParams();
    return await Stripe.instance.isGooglePaySupported(params);
  }
}
