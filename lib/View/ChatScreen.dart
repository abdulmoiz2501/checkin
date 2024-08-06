import 'package:checkin/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/chat_controller.dart';
import '../models/chat_model.dart';
import '../widgets/progress_indicator.dart';
import 'ChatDetailScreen.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final ChatController _chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // This removes the default back button
        backgroundColor: Colors.white, // Set the background color as needed
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFProDisplay',
          ),
        ),
        toolbarHeight: 100, // Adjust height to match the design
      ),
      body: StreamBuilder<List<Chat>>(
        stream: _chatController.getChatContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomCircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading chats'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              const Text(
                "Looks like there are no chats for now.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFProDisplay',
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Don't worry though!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'SFProDisplay',
                ),
              ),
            ],));
          }

          final chats = snapshot.data!;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              bool check = true;
              for (var x in _chatController.firebaseChats.value) {
                if (chat.user.uid == x.uid) {
                  check = false;
                }
              }

              return _buildChatTile(chat, check);
            },
          );
        },
      ),
    );
  }

  Widget _buildChatTile(Chat chat, bool isConnected) {
    print("This it timestamp: ${chat.timestamp}");
    return Slidable(
      key: ValueKey(chat.user.uid),
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.5, // Increase the ratio to make action boxes bigger
        children: [
          SlidableAction(
            onPressed: (context) {
              // Handle pin chat action
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            label: 'Pin chat',
            autoClose: true,
            padding: EdgeInsets.all(0), // Remove default padding
            spacing: 2, // Adjust spacing
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.75, // Increase the ratio to make action boxes bigger
        children: [
          _buildSlidableAction('Disconnect', Colors.black),
          _buildSlidableAction('Block', Color(0xffDB340B)),
          _buildSlidableAction('Report', Color(0xffAD1D00)),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.user.userPictures.first.imageUrl),
          radius: 30,
        ),
        title: Text(
          chat.user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: isConnected
            ? Row(
                children: [
                  Text(
                    'You are now connected with ${chat.user.name}',
                    style: const TextStyle(color: Colors.grey, fontFamily: 'SFProDisplay',),
                  ),
                  const SizedBox(width: 10),
                  /*ElevatedButton(
              onPressed: () {},
              child: const Text('CHAT NOW'),
            ),*/
                ],
              )
            : Row(
                children: [
                  Text(
                    "${chat.message}  •",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(

                      color: Colors.grey,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // VoidFormatter.formatStringTimestampToTime(chat.timestamp),
                    // '12:00 PM'
                    chat.timestamp.isNotEmpty
                        ? '  ${VoidFormatter.finalTimeOnChats(chat.timestamp)}'
                        : '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                ],
              ),
        /*trailing: Text(
          // VoidFormatter.formatStringTimestampToTime(chat.timestamp),
          // '12:00 PM'
          chat.timestamp.isNotEmpty?VoidFormatter.finalTimeOnChats(chat.timestamp) :''
          ,style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),*/
        onTap: () {
          Get.to(() => ChatScreen(chat: chat, lastSeen: chat.timestamp));
        },
      ),
    );
  }

  Widget _buildSlidableAction(String label, Color color) {
    return SlidableAction(
      onPressed: (context) {
        // Handle action
      },
      backgroundColor: color,
      foregroundColor: Colors.white,
      autoClose: true,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12, // Make the text smaller
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ).data,
      padding: EdgeInsets.all(0), // Remove default padding
      spacing: 2, // Adjust spacing
    );
  }
}
