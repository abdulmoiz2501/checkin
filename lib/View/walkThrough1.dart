import 'package:card_swiper/card_swiper.dart';
import 'package:checkin/View/Login.dart';
import 'package:checkin/View/walkThrough2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//WalkThrough1
import '../constants/ScreenUtils.dart';
import '../constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkThrough1 extends StatefulWidget {
  @override
  _WalkThrough1State createState() => _WalkThrough1State();
}

class _WalkThrough1State extends State<WalkThrough1> {
  SwiperController _swiperController = SwiperController();
  int _currentIndex = 0;

  final List<Widget> walkThroughPages = [
    WalkThroughPage1(),
    WalkThroughPage2(),
    WalkThroughPage3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => Login());
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0), // Add padding to push up the progress indicator
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return walkThroughPages[index];
                },
                itemCount: walkThroughPages.length,
                pagination: SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: gradientLeft,
                  ),
                ),
                controller: _swiperController,
                onIndexChanged: (index) {
                  print(index);
                  setState(() {
                    _currentIndex = index;
                  });
                },
                loop: false,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex == walkThroughPages.length - 1) {
                  Get.to(() => Login());
                } else {
                  _swiperController.next();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
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
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Increase padding for button size
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const Text(
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
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class WalkThroughPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.053),
      child: Column(
        children: [
          SizedBox(height: ScreenUtil.responsiveHeight(0.06)),
          Image.asset(
            'assets/walkThrough1.png',
            width: ScreenUtil.responsiveWidth(0.7),
            height: ScreenUtil.responsiveHeight(0.23),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Image.asset(
            'assets/walkThrough1_logo.png',
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.height * 0.14,
          ),
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
                        text: 'Check into a ',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontFamily: 'SFProDisplay',
                          color: textBlackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'venue',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                  'nearby',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontFamily: 'SFProDisplay',
                    color: textBlackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Text(
            'Open up a world of opportunities on your nights out and discover who else is down to meet',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.044,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class WalkThroughPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.053),
      child: Column(
        children: [
          SizedBox(height: ScreenUtil.responsiveHeight(0.06)),
          Image.asset(
            'assets/walkThrough2.png',
            width: ScreenUtil.responsiveWidth(0.7),
            height: ScreenUtil.responsiveHeight(0.23),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Image.asset(
            'assets/walkThrough1_logo.png',
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.height * 0.14,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Connect with people',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontFamily: 'SFProDisplay',
                    color: textBlackColor,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'who have ',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontFamily: 'SFProDisplay',
                          color: textBlackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'checked in',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
              ],
            ),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Text(
            'Take the guess work out of approaching someone new',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.044,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class WalkThroughPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.053),
      child: Column(
        children: [
          SizedBox(height: ScreenUtil.responsiveHeight(0.06)),
          Image.asset(
            'assets/walkThrough3.png',
            width: ScreenUtil.responsiveWidth(0.7),
            height: ScreenUtil.responsiveHeight(0.23),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Image.asset(
            'assets/walkThrough1_logo.png',
            width: MediaQuery.of(context).size.width * 0.14,
            height: MediaQuery.of(context).size.height * 0.14,
          ),
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
                        text: 'Unleash',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontFamily: 'SFProDisplay',
                          color: textBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'new friendships!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontFamily: 'SFProDisplay',
                    color: textBlackColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ScreenUtil.responsiveHeight(0.025)),
          Text(
            'Make the most out of your night and have fun meeting new people',
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.044,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}