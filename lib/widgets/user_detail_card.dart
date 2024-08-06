/*
import 'package:flutter/material.dart';

class UserDetailCard extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int age;
  final String gender;
  final IconData genderIcon;
  final String height;
  final bool showOrientation;
  final String orientation;
  final String description;
  final List<String> checkinGoals;

  UserDetailCard({
    required this.avatarUrl,
    required this.name,
    required this.age,
    required this.gender,
    required this.genderIcon,
    required this.height,
    required this.showOrientation,
    required this.orientation,
    required this.description,
    required this.checkinGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0xFF21262D),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 24.0,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        '$age',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(
                        genderIcon,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        gender,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Height: $height',
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (showOrientation)
                    Text(
                      'Orientation: $orientation',
                      style: TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'What\'s on my mind',
            style: TextStyle(color: Colors.grey),
          ),
          Text(
            '"$description"',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: checkinGoals.map((goal) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: Colors.white),
                ),
                child: Text(
                  goal,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String gender;
  final String height;
  final String sexualPreference;
  final bool showSexualOrientation;
  final String description;
  final List<String> checkinGoals;

  UserCard({
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.sexualPreference,
    required this.showSexualOrientation,
    required this.description,
    required this.checkinGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF21262D),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 30.0,
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SFProDisplay',
                      fontSize: 18.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        age.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Image.asset(
                        gender.toLowerCase() == 'female'
                            ? 'assets/female.png'
                            : gender.toLowerCase() == 'male'
                            ? 'assets/male.png'
                            : 'assets/binary.png',
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        gender,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Height: $height',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                  if (showSexualOrientation)
                    Text(
                      sexualPreference,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            "What's on my mind",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SFProDisplay',
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SFProDisplay',
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Checkin Goals',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SFProDisplay',
            ),
          ),
          Wrap(
            spacing: 5.0,
            children: checkinGoals.map((goal) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF21262D),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  goal,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
