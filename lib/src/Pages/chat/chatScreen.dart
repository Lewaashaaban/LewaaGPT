// ignore: file_names
// ignore_for_file: unused_field, file_names, duplicate_ignore, annotate_overrides, avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my/src/Pages/chat/messages.dart';
import 'package:my/src/Pages/profile/profile_screen.dart';
import 'package:my/src/constants/colors.dart';
import 'package:my/src/constants/imageStrings.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //  dialog flutter for ai
  late DialogFlowtter dialogFlowtter;

  final TextEditingController _controller = TextEditingController();

  // check if ai is replying with a message
  bool isSendingMessage = false;

  List<Map<String, dynamic>> messages = [];

  // to sscroll down to the message automtically
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    dialogFlowtter = DialogFlowtter(jsonPath: 'assets/dialog_flow_auth.json');
  }

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
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(child: MessagesScreen(messages: messages)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                color: Color(0xFF444654),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                    )),
                    IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: Icon(Icons.send_rounded),
                      color: Color.fromRGBO(142, 142, 160, 1),
                    ),
                  ],
                ),
              ),
              if (isSendingMessage) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      SnackBar(content: Text('message is empty'));
    } else {
      setState(() {
        isSendingMessage = true;
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      try {
        DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)),
        );

        setState(() {
          isSendingMessage = false;
        });

        if (response.message != null) {
          setState(() {
            final responseText = response.message!.text?.text?.isNotEmpty ==
                    true
                ? response.message!.text!.text![0]
                : 'No response text provided'; // Provide a default message if text is null or empty
            addMessage(Message(text: DialogText(text: [responseText])));
          });
        } else {
          // Handle the case where Dialogflow didn't provide a response
          print('Dialogflow did not provide a response.');
        }
      } catch (error) {
        // Handle any errors that occur during communication with Dialogflow
        print('Error communicating with Dialogflow: $error');
      }
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
