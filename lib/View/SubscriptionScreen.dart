import 'dart:convert';

import 'package:checkin/View/LikeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../constants/colors.dart';
import '../controllers/payment_controller.dart';
import '../controllers/subscription_controller.dart';
import '../models/payment_model.dart';
import '../models/subscription_model.dart';
import '../services/stripe.dart';
import '../widgets/bottom_bav_bar.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/subscription_card.dart';
import 'package:http/http.dart' as http;

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final List<Map<String, dynamic>> cardData = [
    {
      "title": "WEEKEND",
      "description":
          "The fun starts when Friday finishes. Premium from Friday to Sunday.",
      "price": "5.99",
      "textColor": Colors.white,
      "backgroundColor": Color(0xFF21262D),
      "outlineColor": Colors.black,
      "asset": 'assets/logo_white.png',
    },
    {
      "title": "1 WEEK",
      "description":
          "See what premiums about and Increase your odds of an interesting connection.",
      "price": "12.99",
      "textColor": gradientLeft,
      "backgroundColor": Color(0xFFFFF9F8),
      "outlineColor": gradientRight,
      "asset": 'assets/logo_black.png',
    },
    {
      "title": "1 MONTH",
      "description":
          "Connect with new friends and make it a memorable month of meet-ups.",
      "price": "7.99",
      "textColor": gradientLeft,
      "backgroundColor": Color(0xFFFFF9F8),
      "outlineColor": gradientRight,
      "asset": 'assets/logo_black.png',
    },
    {
      "title": "3 MONTHS",
      "description":
          "Grow your social circle, make memories and stash come cash.",
      "price": "6.99",
      "textColor": gradientLeft,
      "backgroundColor": Color(0xFFFFF9F8),
      "outlineColor": gradientRight,
      "asset": 'assets/logo_black.png',
    },
  ];



  int _currentIndex = 0;
  final SubscriptionController subscriptionController = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        'assets/cross_icon.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.21),
                  Center(
                    child: Text(
                      'Daily limit reached',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Send unlimited daily requests\n with a premium pass',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo_black.png',
                        height: 100, width: 100),
                    SizedBox(width: 10),
                    Container(
                      height: 20,
                      width: 2,
                      color: Color(0xffD9D9D9),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        SizedBox(height: 8),
                        Text(
                          'Premium Pass',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Select a subscription option that is a right fit for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Carousel slider
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width * 1,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          initialPage: 0,
                          viewportFraction: 0.9,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardData.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return SubscriptionCard(
                                title: item['title'],
                                description: item['description'],
                                price: item['price'],
                                textColor: item['textColor'],
                                backgroundColor: item['backgroundColor'],
                                outlineColor: item['outlineColor'],
                                asset: item['asset'],
                              );
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      // Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(cardData.length, (index) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? gradientLeft
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Box with features
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildFeatureRow('assets/heart.png',
                        'Send as many connection requests as you like'),
                    _buildFeatureRow('assets/map.png',
                        'Increase map radius from 250m to 500m'),
                    _buildFeatureRow(
                        'assets/eye.png', 'See everyone who likes you'),
                    _buildFeatureRow('assets/double_up.png',
                        'Jump to the top of the list at venues'),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              // Subscribe button
              /*Obx(() => Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: subscriptionController.isLoading.value
                      ? null
                      : () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      int voucherId;
                      switch (_currentIndex) {
                        case 0:
                          voucherId = 3;
                          break;
                        case 1:
                          voucherId = 4;
                          break;
                        case 2:
                          voucherId = 5;
                          break;
                        case 3:
                          voucherId = 6;
                          break;
                        default:
                          voucherId = 3;
                      }
                      final subscription = SubscriptionModel(
                        userId: user.uid,
                        voucherId: voucherId,
                      );
                      await subscriptionController.addSubscription(subscription);
                    }
                    //Get.back();
                    Future.delayed(Duration(seconds: 3), () {
                      Get.to(() => BottomNavigation(),);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientLeft, gradientRight],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: subscriptionController.isLoading.value
                          ? CustomCircularProgressIndicator()
                          : Text(
                        "Subscribe",
                        style: TextStyle(
                          color: textInvertColor,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )),*/

              ///
              /*Obx(() => Container(
                  height: 50,
                  child: ElevatedButton(

                    onPressed: () async{
                      User? user = FirebaseAuth.instance.currentUser;
                      if(user!= null){
                        int voucherId;
                        double amount;
                        switch(_currentIndex){
                          case 0:
                            voucherId = 3;
                            amount = 3.99;
                            break;
                          case 1:
                            voucherId = 4;
                            amount = 9.99;
                            break;
                          case 2:
                            voucherId = 5;
                            amount = 5.99 * 4; // For 1 month, 5.99 per week
                            break;
                          case 3:
                            voucherId = 6;
                            amount = 4.99 * 4 * 3; // For 3 months, 4.99 per week
                            break;
                          default:
                            voucherId = 3;
                            amount = 3.99;
                        }
                        Future<void> purchaseHook(bool success, String message) async {
                          if (success) {
                            // Handle successful purchase, navigate to another screen or show a success message
                            Get.snackbar("Success", message);
                          } else {
                            // Handle failed purchase, show an error message
                            Get.snackbar("Error", message);
                          }
                        }

                        // Start the purchase process
                        StripeServices.instance.startPurchase(amount, purchaseHook, context);


                        final subscription = SubscriptionModel(
                          userId: user.uid,
                          voucherId: voucherId,
                        );
                        await SubscriptionController().addSubscription(subscription);
                      }

                      // Purchase hook function to handle purchase success/failure


                    print('Subscribe button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0, // Remove shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [gradientLeft, gradientRight],
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: StripeServices.instance.isLoading.value
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(textInvertColor),
                        )
                            : Text(
                          "Subscribe",
                          style: TextStyle(
                            color: textInvertColor,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              Container(
                height: 50,
                child: Obx(() => ElevatedButton(
                  onPressed: StripeServices.instance.isLoading.value || PaymentController().isLoading.value
                      ? null
                      : () async {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      int voucherId;
                      double amount;

                      // Calculate the amount based on the selected index
                      switch (_currentIndex) {
                        case 0:
                          voucherId = 3;
                          amount = 5.99;
                          break;
                        case 1:
                          voucherId = 4;
                          amount = 12.99;
                          break;
                        case 2:
                          voucherId = 5;
                          amount = 7.99 * 4; // For 1 month, 5.99 per week
                          break;
                        case 3:
                          voucherId = 6;
                          amount = 6.99 * 4 * 3; // For 3 months, 4.99 per week
                          break;
                        default:
                          voucherId = 3;
                          amount = 5.99;
                      }

                      final subscription = SubscriptionModel(
                        userId: user.uid,
                        voucherId: voucherId,
                      );

                      // Purchase hook function to handle purchase success/failure
                      Future<void> purchaseHook(bool success, String message) async {
                        if (success) {
                          // Handle successful Stripe payment
                          final payment = PaymentModel(
                            date: DateTime.now().toIso8601String(),
                            amount: amount,
                            reason: 'Subscription Purchase',
                            userId: user.uid,
                            voucherId: voucherId,
                          );
                          final PaymentController paymentController = Get.put(PaymentController());
                          try {
                            // Process payment via Payment API
                            await paymentController.addPayment(payment);

                            if (paymentController.isPaymentSuccessful.value) {
                              // After successful payment processing, call the subscription API
                              await subscriptionController.addSubscription(subscription);

                              // Navigate to another screen or show a success message
                              Get.snackbar("Success", "Payment and subscription successful!");

                              Future.delayed(Duration(seconds: 3), () {
                                Get.to(() => BottomNavigation());
                              });
                            } else {
                              // Handle payment processing error
                              Get.snackbar("Error", "Payment processing failed.");
                            }
                          } catch (e) {
                            // Handle payment processing error
                            Get.snackbar("Error", "Payment processing failed: $e");
                          }
                        } else {
                          // Handle failed Stripe payment
                          Get.snackbar("Error", message);
                        }
                      }

                      // Start the purchase process with the calculated amount
                      await StripeServices.instance.startPurchase(amount, purchaseHook, context);

                      print('Subscribe button pressed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientLeft, gradientRight],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: StripeServices.instance.isLoading.value || PaymentController().isLoading.value
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(textInvertColor),
                      )
                          : Text(
                        "Subscribe",
                        style: TextStyle(
                          color: textInvertColor,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String asset, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(asset, height: 24, width: 24),
          SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
