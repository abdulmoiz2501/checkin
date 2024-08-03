import 'package:carousel_slider/carousel_slider.dart';
import 'package:checkin/services/stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../controllers/get_request_controller.dart';
import '../controllers/subscription_controller.dart';
import '../models/subscription_model.dart';
import '../widgets/bottom_bav_bar.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/subscription_card.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:http/http.dart' as http;

class NoConnections extends StatefulWidget {
  const NoConnections({super.key});

  @override
  State<NoConnections> createState() => _NoConnectionsState();
}

class _NoConnectionsState extends State<NoConnections> {
  String? currentUserId;
  final GetRequestController getRequestController = Get.find();
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
  String getCurrentPrice() {
    switch (_currentIndex) {
      case 0:
        return '5.99';
      case 1:
        return '12.99';
      case 2:
        return (7.99 * 4).toStringAsFixed(2); // For 1 month
      case 3:
        return (6.99 * 4 * 3).toStringAsFixed(2); // For 3 months
      default:
        return '5.99';
    }
  }
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) async{
    //   await _getCurrentUserId();
    // });
  }

  Future<void> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
      print('Current User ID: ${user.uid}');
      getRequestController.fetchRequests(user.uid);
    }
  }

  Future<void> _refreshData() async {
    print('Refresh is called');

    print('got the id');
    // await getRequestController.fetchRequests(currentUserId!);
    await _getCurrentUserId();

    print('done with the refresh');
  }

  Map<String, dynamic>? paymentIntentData;
  Future<void> initPaymentSheet(amount) async {
    try {
      paymentIntentData = await createPaymentIntent(amount.toString(), "USD");

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  allowsDelayedPaymentMethods: true,
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Checkin'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
      }
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        payFee();

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('$error $stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  payFee() {
    try {
      //if you want to upload data to any database do it here
    } catch (e) {
      // exception while uploading data
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Pc5xWRunBM6ve3ypKKr9b6eu3ahTJAv6YNAqWQmTBiauJssC8MOfkVsgCf7nO9aDZ0n7f1vp2fEW16Z9jYheGks00nFqDFpW7',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      if (kDebugMode) {
        print('err charging user: ${err.toString()}');
      }
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  int _currentIndex = 0;
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  @override
  Widget build(BuildContext context) {
    print('In the like  no connection screen');

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'No connections right now',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Check back later',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  "Select A Premium Pass",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
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
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? gradientLeft : Colors.grey,
                      ),
                    );
                  }),
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
                SizedBox(height: 25),
                Obx(() => Container(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: subscriptionController.isLoading.value
                            ? null
                            : () async {
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  int voucherId;
                                  double price;
                                  switch (_currentIndex) {
                                    case 0:
                                      voucherId = 3;
                                      price = 3.99;
                                      break;
                                    case 1:
                                      voucherId = 4;
                                      price = 9.99;
                                      break;
                                    case 2:
                                      voucherId = 5;
                                      price = 5.99;
                                      break;
                                    case 3:
                                      voucherId = 6;
                                      price = 4.99;
                                      break;
                                    default:
                                      voucherId = 3;
                                      price = 3.99;
                                  }
                                  final subscription = SubscriptionModel(
                                    userId: user.uid,
                                    voucherId: voucherId,
                                  );
                                  await StripeServices.instance.initialize();
                                  await StripeServices.instance
                                      .startPurchase(price.toDouble(),
                                          (isSuccess, message) async {
                                    if (isSuccess) {
                                      await subscriptionController
                                          .addSubscription(subscription);
                                    } else {
                                      print("Error Please pay by cash");
                                    }
                                  }, context);

                                  // PlatformPayButton(
                                  //   type: PlatformButtonType.buy,
                                  //   onPressed: () async {
                                  // await StripeServices.instance
                                  //     .startGooglePay();
                                  //   },
                                  // );
                                }
                                //Get.back();
                                Future.delayed(Duration(seconds: 3), () {
                                  Get.to(
                                    () => BottomNavigation(),
                                  );
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
                                    "Subscribe for \$${getCurrentPrice()}",
                                    style: TextStyle(
                                      color: textInvertColor,
                                      fontFamily: 'SFProDisplay',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ]),
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
