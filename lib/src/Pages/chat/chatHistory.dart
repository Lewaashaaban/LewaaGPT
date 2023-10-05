// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatHistory extends StatefulWidget {
  @override
  _ChatHistoryState createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a list to store chat messages
  List<ChatMessage> chatMessages = [];

  Future<void> fetchChatHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;

      final querySnapshot = await _firestore
          .collection('chatHistory')
          .doc(uid)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .get();

      // Process the querySnapshot to populate the chatMessages list
      chatMessages = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ChatMessage(
          text: data['message'],
          chatMessageType: data['sender'] == 'user'
              ? ChatMessageType.user
              : ChatMessageType.bot,
        );
      }).toList();

      // Update the UI to reflect the fetched chat history
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    // Reverse the order of chatMessages list
    // chatMessages = chatMessages.reversed.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat History'),
          centerTitle: true,
        ),
        body: chatMessages.isEmpty
            ? Center(
                child: Text('No chat to show'),
              )
            : ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final chatMessage = chatMessages[index];
                  final backgroundColor =
                      chatMessage.chatMessageType == ChatMessageType.user
                          ? Color(0xff343541)
                          : Colors.black; // Bot message background color

                  Widget messageWidget;

                  if (chatMessage.chatMessageType == ChatMessageType.user) {
                    // User message
                    messageWidget = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            child: Icon(Icons.person,
                                color: Colors.white)), // User icon
                        SizedBox(
                            width:
                                8.0), // Add some space between the icon and text
                        Expanded(
                          child: Text(
                            chatMessage.text,
                            style: TextStyle(
                              color:
                                  Colors.white, // Adjust text color as needed
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Bot message
                    messageWidget = Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromRGBO(16, 163, 127, 1),
                          child: Icon(Icons.tips_and_updates_rounded,
                              color: Colors.white),
                        ), // Bot icon
                        SizedBox(
                            width:
                                8.0), // Add some space between the icon and text
                        Expanded(
                          child: Text(
                            chatMessage.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Colors
                                        .white), // Adjust text color as needed
                          ),
                        ),
                      ],
                    );
                  }
                  // Create a container for the message
                  final messageContainer = Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    padding: EdgeInsets.all(16.0), // Adjust padding as needed
                    color: backgroundColor,
                    child: messageWidget,
                  );
                  return messageContainer;
                }));
  }
}

class ChatMessage {
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessage({required this.text, required this.chatMessageType});
}

enum ChatMessageType { user, bot }
