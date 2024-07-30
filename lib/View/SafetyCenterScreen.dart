import 'package:flutter/material.dart';

import '../constants/colors.dart';



class SafetyCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ).createShader(bounds);
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ).createShader(bounds);
                },
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFProDisplay',
                    color: Colors.white, // This color is just for the mask
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          'Safety centre',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Here\'s what you need to know about safety.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFProDisplay',
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome to CheckIn! As you embark on your journey to meet new people in real life, it is crucial to prioritise safety above all else. Here\'s a basic safety guide to ensure your experiences are enjoyable and secure:',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              _buildParagraph(
                'Communicate Within the App:',
                ' Keep all initial communications within the app’s messaging system. Avoid sharing personal contact information, such as phone numbers or social media profiles, until you feel comfortable and trust the person you’re communicating with.',
              ),
              _buildParagraph(
                'Meet in Public Places:',
                ' When meeting someone for the first time, always choose a public location for your safety. Opt for well-lit areas with plenty of people around, such as cafes, restaurants, or parks. Avoid secluded areas and private residences until you’ve established trust and feel comfortable.',
              ),
              _buildParagraph(
                'Inform a Trusted Friend or Family Member:',
                ' Before meeting someone for the first time, inform a trusted friend or family member about your plans. Share details such as the location, time, and the person you’re meeting. Consider sharing your live location through the app or setting up a check-in system for added security.',
              ),
              _buildParagraph(
                'SOS Feature:',
                ' Familiarise yourself with CheckIn’s SOS feature, which allows you to contact local authorities directly in case of emergencies. Prior to meeting someone, ensure your phone is charged and the SOS feature is easily accessible in case you need immediate assistance.',
              ),
              _buildParagraph(
                'Trust Your Instincts:',
                ' Trust your instincts and be cautious if something doesn’t feel right. If you feel uncomfortable or uneasy at any point during the interaction, it’s okay to end the meeting and leave the situation. Your safety and well-being are paramount.',
              ),
              _buildParagraph(
                'Set Boundaries and Communicate Them:',
                ' Establish clear boundaries with the person you’re meeting and communicate them openly. Respect each other’s boundaries and comfort levels throughout the interaction. If your boundaries are not being respected, don’t hesitate to end the meeting and remove yourself from the situation.',
              ),
              _buildParagraph(
                'Stay Sober and Alert:',
                ' Maintain a clear mind and stay sober during the meeting to make sound decisions and assess the situation accurately. Avoid excessive alcohol or substance consumption, as it can impair your judgment and compromise your safety.',
              ),
              _buildParagraph(
                'Have an Exit Strategy:',
                ' Plan an exit strategy in advance in case the meeting doesn’t go as expected. Arrange a signal with a friend or family member to discreetly indicate if you need assistance or want to leave the situation. Trust your instincts and prioritize your safety above all else.',
              ),
              SizedBox(height: 16),
              Text(
                'Remember, while CheckIn strives to create a safe and secure environment for meeting new people, your personal safety is ultimately your responsibility. By following these safety guidelines and trusting your instincts, you can enjoy safe and rewarding social experiences when meeting people in real life through the app.',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0, // Remove shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [gradientLeft, gradientRight],
                    ),
                    borderRadius: BorderRadius.circular(25),

                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    alignment: Alignment.center,
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: textInvertColor,
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String boldText, String normalText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: RichText(
        text: TextSpan(
          text: boldText,
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: normalText,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
