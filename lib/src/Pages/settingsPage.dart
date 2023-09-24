// ignore_for_file: file_names
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool _isDarkModeEnabled = false;
//   String _selectedLanguage = 'English';

//   List<String> _languages = ['English', 'Spanish', 'French', 'German'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Language:',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             DropdownButton<String>(
//               value: _selectedLanguage,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedLanguage = newValue!;
//                   _updateLanguage(context, newValue);
//                 });
//               },
//               items: _languages.map((language) {
//                 return DropdownMenuItem<String>(
//                   value: language,
//                   child: Text(language),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'Dark Mode:',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Switch(
//               value: _isDarkModeEnabled,
//               onChanged: (newValue) {
//                 setState(() {
//                   _isDarkModeEnabled = newValue;
//                 });
//                 _updateTheme(context, newValue);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

