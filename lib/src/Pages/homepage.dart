// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my/src/Pages/profile/widgets/sidebar.dart';
// import 'package:my/src/Pages/profile/profile_screen.dart';
// import 'package:my/src/constants/colors.dart';
// import 'package:my/src/constants/imageStrings.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<String> messages = [];

//   void _sendMessage(String message) {
//     setState(() {
//       messages.add('User: $message');
//       messages.add('AI: $message');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         leading: Icon(
//           Icons.menu,
//           //For Dark Color
//           color: isDark ? tWhiteColor : tDarkColor,
//         ),
//         title: Text('LewaaGPTtttt',
//             style: Theme.of(context).textTheme.headlineMedium),
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 20, top: 2),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               //For Dark Color
//               color: isDark ? tSecondaryColor : tCardBgColor,
//             ),
//             child: IconButton(
//                 onPressed: () {
//                   Get.to(() => const ProfileScreen());
//                 },
//                 icon: const Image(image: AssetImage(tUSerIamge))),
//           )
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: messages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(messages[index]),
//           );
//         },
//       ),
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   hintText: 'Type your message...',
//                   border: OutlineInputBorder(),
//                 ),
//                 onFieldSubmitted: (message) {
//                   if (message.trim().isNotEmpty) {
//                     _sendMessage(message);
//                   }
//                 },
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 // You can also use a button instead of onFieldSubmitted for sending messages
//                 String message =
//                     'Your AI response here'; // Replace with actual AI response
//                 if (message.trim().isNotEmpty) {
//                   _sendMessage(message);
//                 }
//               },
//               icon: Icon(Icons.send),
//             ),
//           ],
//         ),
//       ),
//       drawer: SideBar(
//         fullName: 'Lewaa shaaban',
//         imageUrl:
//             'https://tse4.mm.bing.net/th?id=OIP.fzSnClvueUiDCZNJINMWywHaEK&pid=Api&P=0&h=220',
//       ),
//     );
//   }
// }
