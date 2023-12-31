// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Pages/chat/messages2.dart';
import 'package:my/src/Pages/profile/profile_screen.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';
import 'package:my/src/repository/chat-repository/chat-repository.dart';

import '../../Backend/models/chatModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
 

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  late bool isLoading;

  // fxn to save chat messages
  Future<void> saveChatMessage(
      String message, ChatMessageType chatMessageType) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;

      final chatData = {
        'message': message,
        'timestamp': FieldValue
            .serverTimestamp(), // Use server timestamp for accurate sorting
        'sender': chatMessageType == ChatMessageType.user ? 'user' : 'bot',
      };

      // Save the chat message to Firebase Firestore
      await FirebaseFirestore.instance
          .collection('chatHistory')
          .doc(uid)
          .collection('messages')
          .add(chatData);
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    // _scrollToLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:
            Text('LewaaGPT', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark ? tSecondaryColor : tCardBgColor,
            ),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const ProfileScreen());
                },
                icon: const Image(image: AssetImage(tUSerIamge))),
          )
        ],
      ),
      // backgroundColor: isDark ? tSecondaryColor : tCardBgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildList(),
            ),
            Visibility(
              visible: isLoading,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _buildInput(),
                  _buildSubmit(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // submit button
  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        color: Color(0xff444654),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: Color.fromRGBO(142, 142, 160, 1),
          ),
          onPressed: () async {
            setState(
              () {
                final message = _textController.text;
                final sender = "user"; // Identify the sender as the user
                _messages.add(
                  ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user,
                  ),
                );
                isLoading = true;
              },
            );
            var input = _textController.text;
            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollToLastMessage());

            // Save the user's message to Firestore
            await saveChatMessage(input, ChatMessageType.user);
            generateResponse(input).then((value) async {
              setState(() {
                isLoading = false;

                // // Add the AI's message
                _messages.add(
                  ChatMessage(
                    text: value, // AI's response
                    chatMessageType: ChatMessageType.bot,
                  ),
                );

                _scrollToLastMessage();
              });

              await saveChatMessage(value, ChatMessageType.bot);
              _scrollToLastMessage();
            });

            _textController.clear();
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollToLastMessage());
          },
        ),
      ),
    );
  }

  // text field to send message
  Expanded _buildInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: const InputDecoration(
          fillColor: Color(0xff444654),
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        var message = _messages[index];
        return ChatMessageWidget(
          text: message.text,
          chatMessageType: message.chatMessageType,
        );
      },
    );
  }

  void _scrollToLastMessage() {
    if (_messages.isNotEmpty) {
      final lastIndex = _messages.length - 1;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
