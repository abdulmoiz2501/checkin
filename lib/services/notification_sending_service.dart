import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';


class NotificationSendingService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "checkin-7a4d5",
      "private_key_id": "3062095676ab649308dbfcaa37fc5d18f9b2e5eb",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCK8ZcO5t4JE4Ax\nTVhz3rak7a3lJsA0xd3YgyCmYjZq9J7gTPLQMzd8TiT8C0UWtMjn1PYYQ4yItC3V\nTZlfmY2SBX4191JKBepuAw7yxghff0bb9X357MGqhUC+DHxGMyhRPUSwutZbwHHS\nzUoB/uA7FpweCb4snhd/+mK0vKyj4S9cgtmVHOGDsBKWWxawVzU5kuMVKqaF4ZV3\nI2mX7mMf7Ysaaig+ie+CIdjq4IiqqZTvg5UIt19v6M1+Dt+slxJ19WJTTh39Gy/E\n/mBt0u9KX4AcEsBrtrxmzO3neSVX0RIOQPU0oKc0ERaRF9BdcptdozbMd5vdl6cN\nkiW5n87PAgMBAAECggEABxJm1YurT3Dzpw7AasgHfyYtzKpdQWe0yUQF/GdRTROo\nUShOz4lb0J2K77KEe18LlBPYdsGxZx/XRAe6v7fpZxOVKfAC+zYz3rzpx4eMKOLU\nhiDc9ESNqD03X1+epQAOPvGhtmZmv1gbMwHfO3IakvICqNtmwjnwXkODP0m/IRQj\niQ7fTm28BTegrhdlPWbX9IGl9lwQdM2OOlR/Sa/5xKY9h6ECePKoHLPF6t+NHdvF\neHUyfEisnH3hEix1ePaPBmbkS5QzpWeXUFTVeC2dMk5gTbmwPoccO3WpVKMxM0yQ\nveCLDf57eNZNKYU3GarrJg4bQkNJAPCz8Va1H77PYQKBgQC/2A4idyd9BDxwHsyI\njbGS7kLOrPOk9rX5tyYbF5YHoKcAesRh8jtFJoeI13kUNAy/JNYwu5Djd8WAJ8gb\nzwXZI+/owPqfJJMENer8JPfGE0CGrlrL0A4DZiwdhw8e/kqUDaIYwm5cM5jhWk5i\nu9QLyugoiv7Gs6EOIdKcwBu4XwKBgQC5aLGSnSZL8Vg38G0rtgTf0V4qQOsx5N6U\nDvuFBzgj4oiOHOG0plIdS9PTL4Ip1aIUbLbWAJ89YfwKo/RDsUG3NoBecau8h2SU\n3FkRKt4S/ZgVljCndiDmcZTOdeoGQsZ4Sgt86CpaMturzPnVRfud88uOwHiOcA4d\nw/gjZ5M/kQKBgFsCMeJjyFXkVo+R7NGy9lSPtx24qnTNnRJzsh4UGFZR/ieaFeOp\nODjbyFxAa+4LqyhaX0oLEPb38LeVJ7cZhNq3064FLl+kyCGtOmaXWvuaUngR6nzZ\nnGw8Yh033xKC6/pEZWt9gUE4MQRnBNyN4lAd1/izx52XxYWgwfsen4fdAoGBALg3\nyZd/BPoXxitue0ofBCDOCd25uvZMDMrXSBkY3zLodf2dvLSdPKFXIhSG87FVTkE0\n80UWQSHgJWj9Fknb6Qt833b3QkeDzvAJL4XbLeN4jI+GNrlsqavN1qh8iBXIayJB\nj8B/fPU56wF8HA9IBYUfInWnzyDXPW9ds0KaOrfBAoGBAKr8WCASj55C+EmdGXs+\nCdQTOhasPf2pWHK1Efg834WV6GhQcASUaWSKwdU06OvC/lpylEFGnZXSPpTCgNM2\nTztrT4Tuu05q+wRowfT9oZIcByeAs6tH0gC3zs3QZNx6BdXHlIe9dSc1OccUeY4n\njTrR5ZR8oNfkXRuja/f0rQZ5\n-----END PRIVATE KEY-----\n",
      "client_email": "checkin@checkin-7a4d5.iam.gserviceaccount.com",
      "client_id": "100880044129026525516",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/checkin%40checkin-7a4d5.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    var scopes = [
      // 'https://www.googleapis.com/auth/userinfo.email',
      // 'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );
    auth.AccessCredentials credentials =
    await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  // Function to send notification using HTTP v1 API
  static Future<void> sendNotification(
      String token, Map<String, dynamic> messagePayload) async {
    String url =
        'https://fcm.googleapis.com/v1/projects/checkin-7a4d5/messages:send';
    Uri uri = Uri.parse(url);

    String accessToken = await getAccessToken();

    var response = await http.post(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(messagePayload),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }

  // Function to send message notification
  static Future<void> sendMessageNotification(
      String token) async {
    var messagePayload = {
      'message': {
        'token': token,
        'notification': {
          'title': 'New Message',
          'body': 'You have received a new message',
          'icon': 'launcher_icon',
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done',
        },
      },
    };

    await sendNotification(token, messagePayload);
  }

// Function to send friend request notification
  static Future<void> sendFriendRequestNotification(
      String token) async {
    var messagePayload = {
      'message': {
        'token': token,
        'notification': {
          'title': 'Friend Request',
          'body': 'You have received a new connection request',
          'icon': 'launcher_icon',

        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '2',
          'status': 'done',
        },
      },
    };

    await sendNotification(token, messagePayload);
  }

// Function to send friend request accepted notification
  static Future<void> sendFriendRequestAcceptedNotification(
      String token) async {
    var messagePayload = {
      'message': {
        'token': token,
        'notification': {
          'title': 'Friend Request Accepted',
          'body': 'You have a new connection',
          'icon': 'launcher_icon',
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '3',
          'status': 'done',
        },
      },
    };

    await sendNotification(token, messagePayload);
    }

  //This is the function to get the device token of the user with firebaseId
  static Future<Map<String, dynamic>?> getUserTokenFromFirestore(
      String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("user_data")
          .doc(userId)
          .get();

      if (snapshot.exists) {
        return snapshot.data();
      } else {
        print('User data not found for userId: $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
    }
}