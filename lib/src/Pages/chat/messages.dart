import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({super.key, required this.messages});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          Color textColor = widget.messages[index]['isUserMessage']
              ? Colors.white // Text color for user messages
              : Colors.white; // Text color for non-user messages

          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.grey.shade900.withOpacity(0.8)
                            : Colors.grey.shade800),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(
                      widget.messages[index]['message'].text.text[0],
                      style: TextStyle(color: textColor),
                    )),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
