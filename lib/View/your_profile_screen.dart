import 'package:checkin/View/SubscriptionScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../constants/colors.dart';
import '../controllers/view_profile_controller.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/selectable_button.dart';

class YourProfileScreen extends StatelessWidget {
  YourProfileScreen({super.key});



  final ViewProfileController controller = Get.put(ViewProfileController());
  RxString selectedOption = ''.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await controller.fetchUserProfile();
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CustomCircularProgressIndicator());
        } else if (controller.userProfile.value == null) {
          return Center(child: Text('Failed to load profile'));
        } else {
          var user = controller.userProfile.value!;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: user.userPictures.isNotEmpty
                                  ? NetworkImage(user.userPictures[0].imageUrl)
                                  : AssetImage('assets/ava_1.png')
                                      as ImageProvider,
                              radius: 40,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      user.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'SFProDisplay',
                                      ),
                                    ),
                                    Text(
                                      '   ${user.age}   ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SFProDisplay',
                                      ),
                                    ),
                                    Image.asset(
                                      user.gender.toLowerCase() == 'female'
                                          ? 'assets/female.png'
                                          : user.gender.toLowerCase() == 'male'
                                          ? 'assets/male.png'
                                          : 'assets/binary.png',
                                      height: 12,
                                      width: 12,
                                    ),
                                    Text(
                                      '   ${user.gender}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SFProDisplay',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  'Height: ${user.height == 0 ? 'N/A' : '${user.height} cm'} | ${user.sex}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SFProDisplay',
                                  ),
                                ),

                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF09819),
                                          Color(0xFFEDDE5D)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 8.0),
                                    child: Text(
                                      user.subscribed
                                          ? 'Subscription Active'
                                          : 'No Subscription',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: textInvertColor,
                                        fontFamily: 'SFProDisplay',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Photos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textBlackColor,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      SizedBox(
                        height: 110,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(vertical: 7.0),
                            itemCount: user.userPictures.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 95,
                                width: 100,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                decoration: BoxDecoration(
                                    color: hintTextColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          user.userPictures[index].imageUrl),
                                      fit: BoxFit.cover,
                                    )),
                              );
                            }),
                      ).marginOnly(bottom: 5.0),
                      Text(
                        'What’s On My Mind',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textBlackColor,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      Text(
                        user.description,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: textBlackColor,
                            fontFamily: 'SFProDisplay',
                            fontStyle: FontStyle.italic),
                      ).marginSymmetric(vertical: 6.0),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        'Checkin Goals',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textBlackColor,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      Text(
                        'These are your intentions when entering a venue. You can change these every time you check in.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          fontFamily: 'SFProDisplay',
                        ),
                      ).marginSymmetric(vertical: 6.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Obx(
                          () => SelectableButtonGroup(
                            options: [
                              'Friends',
                              'Networking',
                              'Dates',
                              'Love',
                              'Casual',
                              'Food',
                              'Explore city',
                              'Parties',
                              'Pub crawls',
                              'Drinking buddies'
                            ],
                            initialSelected: selectedOption.value,
                            onSelected: (value) {
                              selectedOption.value = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        'Sexual orientation',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textBlackColor,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      Text(
                        'Not shown on profile',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: textMainColor,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                foregroundColor: textInvertColor,
                                backgroundColor: textBlackColor,
                                side: BorderSide(color: textBlackColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: Text(user.sex),
                      )
                          .marginSymmetric(vertical: 5.0),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      if (!user.subscribed) ...[
                        Row(
                          children: [
                            Image.asset(
                              'assets/checking_in.png',
                              height: 20.0,
                              width: 20.0,
                            ),
                            Text(
                              'Checkin',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: textBlackColor,
                                fontFamily: 'SFProDisplay',
                              ),
                            ).marginSymmetric(horizontal: 6.0),
                            Container(
                              height: 15.0,
                              width: 2,
                              color: hintTextColor,
                            ),
                            Text(
                              'Premium Pass',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: textBlackColor,
                                fontFamily: 'SFProDisplay',
                              ),
                            ).marginSymmetric(horizontal: 6.0),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          'Explore our range of flexible subscription options that is a right fit for you.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textBlackColor,
                            fontFamily: 'SFProDisplay',
                          ),
                        ).marginOnly(bottom: 4.0),
                        premiumListWidget('assets/heart_selected.png',
                            'Send as many connection requests as you like'),
                        premiumListWidget('assets/map.png',
                            'Increase map radius from 250m to 500m'),
                        premiumListWidget(
                            'assets/eye.png', 'See who likes you'),
                        premiumListWidget('assets/double_up.png',
                            'Connect with verified members only'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              colors: [gradientLeft, gradientRight],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(()=> SubscriptionScreen());
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
                                alignment: Alignment.center,
                                child: Text(
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'Your subscription will auto-renew for the same price and package length until you cancel via App Store or Play Store settings, and you agree to our',
                                  style: TextStyle(
                                    color: textBlackColor,
                                    fontFamily: 'SFProDisplay',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: ' terms.',
                                  style: TextStyle(
                                    color: textBlackColor,
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'SFProDisplay',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).marginSymmetric(vertical: 8.0),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget premiumListWidget(String img, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(img, height: 26, width: 26, color: Color(0xFF7A7D81))
            .marginSymmetric(horizontal: 5.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF7A7D81),
            fontFamily: 'SFProDisplay',
          ),
        ),
      ],
    ).marginSymmetric(vertical: 1.0);
  }
}
