import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/ScreenUtils.dart';
import '../constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Login.dart';

class WalkThrough3 extends StatelessWidget {
  final PageController controller = PageController(initialPage: 2, viewportFraction: 1);
  WalkThrough3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20, // Specify the desired width
            height: 20, // Specify the desired height
            child: Image.asset('assets/back_arrow.png'),  // Load your SVG image
          ),
          // Load your SVG image
          onPressed: () {
            Get.back();
            // Action when the leading icon is pressed
            print("Leading icon pressed");
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Action when Skip button is pressed
              print("Skip pressed");
            },
            child: Text(
              "SKIP",
              style: TextStyle(
                color: textMainColor,
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil.responsiveHeight(0.06), // 5%
            ),
            //Image
            Container(
              child: Image.asset(
                'assets/walkThrough3.png',
                width: ScreenUtil.responsiveWidth(0.7), // 70%
                height: ScreenUtil.responsiveHeight(0.23),
              ),
            ),
            SizedBox(
              height: ScreenUtil.responsiveHeight(0.025), // 5%
            ),
            //Logo
            Container(
              child: Image.asset(
                'assets/walkThrough1_logo.png',
                width: MediaQuery.of(context).size.width * 0.19,
                height: MediaQuery.of(context).size.height * 0.19,
              ),
            ),
            //check into
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Chat.Meet.',
                          style: VoidTextTheme.lightTextTheme.headlineLarge?.copyWith(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: <Color>[gradientLeft, gradientRight],
                                stops: [0.0, 0.7],
                              ).createShader(Rect.fromLTWH(200.0, 100.0, 150.0, 70.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'And take it from there',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: ScreenUtil.responsiveHeight(0.025), // 5%
            ),
            //Description
            Container(
              child: Text(
                'Ditch the endless swiping for good\nand make some memories you won\'t forget',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.044,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //Progress
            Container(
            ),
            SizedBox(
              height: ScreenUtil.responsiveHeight(0.05), // 5%
            ),
            SmoothPageIndicator(
              controller: controller, // PageController
              count: 3, // Total number of pages
              effect: WormEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: gradientLeft, // Color of the active dot
                dotColor: Colors.grey, // Color of inactive dots
              ),
            ),
            SizedBox(
              height: ScreenUtil.responsiveHeight(0.05), // 5%
            ),
            //Next Button
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [gradientLeft, gradientRight],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => Login());
                  print("Next pressed");
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
                    child: Text(
                      "Next",
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

          ],
        ),
      ),
    );
  }
}
