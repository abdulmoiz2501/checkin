import 'dart:convert';

import 'package:checkin/models/chat_model.dart';
import 'package:checkin/models/single_chat_model.dart';
import 'package:checkin/models/user_model.dart';
import 'package:checkin/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../constants/api_constant.dart';
import '../services/notification_sending_service.dart';

class ChatController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var messageTextController = TextEditingController();
  RxList<UserModel> firebaseChats = <UserModel>[].obs;


  Future<UserModel?> fetchUser(String uid) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(
          '$api/api/v1/users/getUsers?uid=$uid'));

      print(
          'Response status of USER CONTROLLER FETCH USER ON LOGIN/SIGNUP: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true) {
          print("this is the user from api: " + data['user'].toString());
          final UserModel user = UserModel.fromJson(data['user']);
          print("this is the user from api: " + user.name.toString());
          return user;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      isLoading(false);
    }
  }
  Future<List<UserModel>> fetchFriends() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(
          '$api/api/v1/requests/getFriendList?userId=${firebaseAuth.currentUser!.uid}'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true) {
          List<UserModel> friends = [];
          for (var friend in data['friends']) {
            final user = await fetchUser(friend['UId']);
            if (user != null) {
              friends.add(user);
            }
          }
          return friends;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      return [];
    } finally {
      isLoading(false);
    }
  }
  Stream<List<Chat>> getChatContacts() async* {
  final List<UserModel> friends = await fetchFriends();

  firebaseChats.clear();
    // friends.value = await fetchFriends();
    yield* firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((snapshot) async {
      List<Chat> chats = [];
      for (var doc in snapshot.docs) {
        final userFirebaseId = doc['userId'];
        final user = await fetchUser(userFirebaseId);
        if (user != null) {
          firebaseChats.add(user);

          chats.add(
            Chat(
              isOnline: true,
              user: user,
              message: doc['lastText'],
              timestamp: doc['timeSent'].toString(),
            ),
          );
        }
      }

      for (var friend in friends) {
        if (!chats.any((chat) => chat.user.uid == friend.uid)) {
          chats.add(
            Chat(
              isOnline: false,
              user: friend,
              message: '',
              timestamp: '',
            ),
          );
        }
      }
      return chats;
    });
  }

  // Stream<List<Chat>> getChatContacts() {
  //   return firebaseFirestore
  //       .collection('users')
  //       .doc(firebaseAuth.currentUser!.uid)
  //       .collection('chats')
  //       .snapshots()
  //       .asyncMap(
  //         (event) async {
  //       List<Chat> contacts = [];
  //       for (var doc in event.docs) {
  //         print('The list of chat contacts is :${doc.data()}');
  //         // var chatContact = ChatContact.fromMap(doc.data());
  //         // print(doc.data());
  //
  //         // var userData = await firebaseFirestore
  //         //     .collection('users')
  //         //     .doc(chatContact.contactId)
  //         //     .get();
  //         // var user = UserModel.fromMap(userData.data()!);
  //         final userFirebaseId = doc['userId'];
  //         print('User Firebase ID: $userFirebaseId');
  //         final user = await fetchUser(userFirebaseId);
  //
  //         print('data of chat of doc is :${doc.data()}');
  //
  //         contacts.add(
  //           Chat(
  //             isOnline: false,
  //             user: user!,
  //             message: doc['lastText'],
  //             timestamp:
  //             VoidFormatter.formatFirestoreTimestamp(doc['timeSent']),
  //           ),
  //         );
  //       }
  //       return contacts;
  //     },
  //   );
  // }

  Stream<List<SingleChat>> getMessages({
    required String otherUserId,
  }) {
    //It gets the stream of messages from the database
    return firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(otherUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map(
          (event) {
        List<SingleChat> messages = [];
        for (var doc in event.docs) {
          print('The list of messages is :${doc.data()}');
          messages.add(
            SingleChat.fromMap(
              doc.data(),
            ),
          );
        }
        return messages;
      },
    );
  }

  Future<void> _saveDataToContactsSubCollection(
      String senderUserId,
      String recieverUserId,
      DateTime time,
      String text,
      ) async {
//Then this is uploaded to the firestore where it can be accessible to the reciver person.
// Users -> recieverId (To get the document of the reciever) => and then chats collection in that chat collection the
//Chat is stored with the id of the sender in order to identify who sent it
    await firebaseFirestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      'userId': senderUserId,
      'lastText': text,
      'timeSent': time,
    });

    await firebaseFirestore
        .collection('users')
        .doc(senderUserId)
        .collection('chats')
        .doc(recieverUserId)
        .set({
      'userId': recieverUserId,
      'lastText': text,
      'timeSent': time,
    });
  }

  //This mehthood will store the data in the main messages collection where all the messages with the
  //contact are stored
  Future<void> _saveTextToMessageSubCollection({
    required String recieverUserId,
    required String messageId,
    required String text,
    required DateTime timeSent,
  }) async {
//Here we have converted our message to message model and now to store it we have to store in both sender and user collection
//For sender we will store it in the below collection
    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .doc(messageId)
        .set(
      {
        'senderId': firebaseAuth.currentUser!.uid,
        'recieverId': recieverUserId,
        'text': text,
        'timeSent': timeSent,
        'messageId': messageId,
        'isSeen': false,
      },
    );

//For saving it for reciever we will modify it a little bit
//We will goto the reciever document instead of sender because we are updating it for the reciever
//and then in the chats we will update the sender document

    await firebaseFirestore
        .collection('users')
        .doc(recieverUserId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(
      {
        'senderId': firebaseAuth.currentUser!.uid,
        'recieverId': recieverUserId,
        'text': text,
        'timeSent': timeSent,
        'messageId': messageId,
        'isSeen': false,
      },
    );
  }

  Future<void> sendTextMessage({
    required String senderUid,
    required String text,
    required String recieverUserId,
  }) async {
    try {
      var sentTime = DateTime.now();
      var messageId = Uuid().v1();
      isLoading.value = true;

      //This function stores the message to database where on the chats screen it's displayed like only the last text s
      //Profile picture , name ,time at which the message was sent
      await _saveDataToContactsSubCollection(
        senderUid,
        recieverUserId,
        sentTime,
        text,
      );

      //This mehthood will store the data in the main messages collection where all the messages with the
      //contact are stored
      await _saveTextToMessageSubCollection(
        recieverUserId: recieverUserId,
        messageId: messageId,
        text: text,
        timeSent: sentTime,
      );

      messageTextController.clear();
      isLoading.value = false;
      final data = await NotificationSendingService.getUserTokenFromFirestore(recieverUserId);
      await NotificationSendingService.sendMessageNotification(
        data!['token'],
        //userController.user.value.fullName,
      );
      //This is the function to send the notification to the user
      // final data = await UserService.getUserTokenFromFirestore(recieverUserId);
      // await NotificationSendingService.sendMessageNotification(
      //   data!['token'],
      //   userController.user.value.fullName,
      // );
    } catch (e) {
      // VoidLoaders.errorSnackBar(
      //   title: 'Error',
      //   message: e.toString(),
      // );
    }
    }
}