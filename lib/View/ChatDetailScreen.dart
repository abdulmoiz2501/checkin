import 'package:checkin/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/single_chat_model.dart';
import '../utils/formatters/formatter.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  final String lastSeen;

  const ChatScreen({required this.chat, required this.lastSeen, Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {"text": "Hello, Ivan! :)", "isMe": false},
    {"text": "How are you doing?", "isMe": false},
    // Add more messages here
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.chat.user.userPictures.first.imageUrl),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat.user.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(          widget.lastSeen.isNotEmpty? VoidFormatter.finalTimeOnChats(widget.lastSeen) :''
                    , style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.only(bottom: 0 , top: 0),
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              // Handle menu selection
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Disconnect',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    'Report',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 16,
                      color: Color(0xFFAD1D00),
                    ),
                  ),
                ),
              ),
              PopupMenuItem<int>(
                padding: EdgeInsets.all(0),
                value: 2,
                child: Container(
                  width: double.infinity,
                  color: Color(0xFFAD1D00),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Text(
                    'Help: Call 000',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
            color: Colors.white, // Set popup background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<SingleChat>>(
              stream: chatController.getMessages(otherUserId: widget.chat.user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading messages'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                final messages = snapshot.data!;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                  }
                });
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(10),
                  // reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    bool isMe = message.fromUser == chatController.firebaseAuth.currentUser!.uid;
                    return _buildMessageBubble(message.message, isMe);
                  },
                );
              },
            ),
          ),
          _buildMessageInputField(chatController),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildMessageInputField( ChatController chatController) {


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Row(
        children: [
/*          Text('Aa', style: TextStyle(fontSize: 24, color: Colors.grey)),
          SizedBox(width: 10),*/
          Expanded(
            child: TextField(
controller:chatController.messageTextController,
              decoration: InputDecoration(
                hintText: 'Aa',

                hintStyle:  TextStyle(fontSize: 24, color: Colors.grey),
                filled: true,
                fillColor: Colors.black.withOpacity(0.06),
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            //
            // icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
            icon: Icon(Icons.send, color: Colors.grey),
            onPressed: () {
              // Handle emoji button press
              if (chatController.messageTextController.text.trim().isNotEmpty) {
    chatController.sendTextMessage(
    senderUid: chatController.firebaseAuth.currentUser!.uid,
    text: chatController.messageTextController.text.trim(),
    recieverUserId: widget.chat.user.uid,
    );
    chatController.messageTextController.clear();}
            },
          ),
        ],
      ),
    );
  }
}
