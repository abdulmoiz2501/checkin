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

  final _publishableKeyTest = 'pk_test_51Pfzw1RumBeUNDT0JGEdspy9br3CeTMmxKL7kCJXu5AE77OEZbtRHu0DM1Juk4KU18uejWT0z6j7FJc0LMPzCF3C00Wwpvk1rx';
      //'pk_live_51Pfzw1RumBeUNDT0vz8WmbhnGAgUoYqNyDSmYzRaS8yC3ghhWts1d4AIEq0vBHSj5dNbYBwzdvJUFtAhnNJryj5k000e8ZvJdW';
  final _secretKeyTest = 'sk_test_51Pfzw1RumBeUNDT0U8uNKJusg891Q1K04lBdqlo8D2tZK8klrwADW3k96blMEJ0nlM43NEwNhc7LB3yFVsKIhYh9001D3vNDlW';
      //'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';

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
      
      /*var gpay = PaymentSheetGooglePay(merchantCountryCode: "AU",
      currencyCode: "AUD",
        testEnv: true,
      );*/
      
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          customerId: paymentIntentData['id'],
          applePay: Platform.isIOS
              ? PaymentSheetApplePay(
                  merchantCountryCode: 'US',
                  buttonType: PlatformButtonType.values.first
                )
              : null,
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode : 'USD',
            testEnv: isDebugMode,
            amount: _calculate(amount),
            ///CHANGED BUTTON TYPEEE
            buttonType: PlatformButtonType.googlePayMark
            //buttonType: PlatformButtonType.buy
          ),
          style: ThemeMode.light,
          merchantDisplayName: 'My Ticket',
        
        ),
      )
          .then((val) async {
            print("Should show google pay");
        await _showPaymentIntentSheet(purchaseHook);
      });
    } catch (e, s) {
      log('@startPurchase onCatch=====> $e\n$s');
      purchaseHook.call(false, e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }
 Future<void> startGooglePay() async {
  final googlePaySupported = await Stripe.instance
      .isPlatformPaySupported(googlePay: IsGooglePaySupportedParams());
  if (googlePaySupported) {
    try {
      // 1. fetch Intent Client Secret from backend
     
      const clientSecret = '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';
      // 2.present google pay sheet
      await Stripe.instance.confirmPlatformPayPaymentIntent(
          clientSecret: clientSecret,
          confirmParams: PlatformPayConfirmParams.googlePay(
            googlePay: GooglePayParams(
              testEnv: true,
              merchantName: 'Example Merchant Name',
              merchantCountryCode: 'US',
              currencyCode: 'USD',
            ),
          )
          // PresentGooglePayParams(clientSecret: clientSecret),
          );
      // Get.snackbar(
      //   const SnackBar(
      //       content: Text('Google Pay payment succesfully completed')),
      // );
    } catch (e) {
      if (e is StripeException) {
        log('Error during google pay',
            error: e.error, stackTrace: StackTrace.current);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: ${e.error}')),
        // );
      } else {
        log('Error during google pay',
            error: e, stackTrace: (e as Error?)?.stackTrace);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Error: $e')),
        // );
      }
    }
  } else {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Google pay is not supported on this device')),
    // );
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
}
