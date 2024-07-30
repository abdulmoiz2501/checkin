import 'package:flutter/cupertino.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String description;
  ///fff
  final String price;
  final Color textColor;
  //
  final Color backgroundColor;
  final Color outlineColor;
  final String asset;

  const SubscriptionCard({
    required this.title,
    required this.description,
    required this.price,
    required this.textColor,
    required this.backgroundColor,
    required this.asset,
    required this.outlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: outlineColor)// More curved edges
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                asset,
                height: 20,
                width: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ,
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: 40),
                  Text(
                    '\$$price',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'PASS',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: textColor,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                  Column(
                    children: [
                      Text(
                        'per week',
                        style: TextStyle(
                          fontFamily: 'SF Pro',
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(height: 8, ),

              Text(
                description,
                style: TextStyle(
                  fontFamily: 'SF Pro',
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}