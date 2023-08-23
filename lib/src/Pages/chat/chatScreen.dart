// ignore: file_names
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
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    dialogFlowtter = DialogFlowtter(jsonPath: 'assets/dialog_flow_auth.json');
  }

  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          //For Dark Color
          color: isDark ? tWhiteColor : tDarkColor,
        ),
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
      body: Container(
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
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}
