// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tradingapp_bot/Constants/color_constants.dart';
// import '../../../viewmodels/socket/socket_controller_new.dart';
// import '../../dashboard_screen.dart';
//
// class DataScreen extends StatelessWidget {
//   const DataScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final SocketController socketController = Get.put(SocketController());
//
//     return Scaffold(
//       backgroundColor: primarycolor,
//       drawer: const DrawerMain(),
//       appBar: AppBar(title: Text('Socket Data (Mock)')),
//       body: Obx(() {
//         if (socketController.botData.isEmpty) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           List<String> fieldsToDisplay = ["coins", "singleField", "details", "metrics","alert","lastcoin"];  // Specify fields to display
//           List<Widget> items = _buildList(socketController.botData, fieldsToDisplay);
//           return ListView(
//             children: items,
//           );
//         }
//       }),
//     );
//   }
//
//   List<Widget> _buildList(dynamic data, List<String> fieldsToDisplay) {
//     List<Widget> widgets = [];
//
//     if (data is Map<String, dynamic>) {
//       data.forEach((key, value) {
//         if (fieldsToDisplay.contains(key)) {
//           if (value is Map) {
//             value.forEach((subKey, subValue) {
//               widgets.add(
//                 ListTile(
//                   title: Text('$subKey: $subValue'),
//                 ),
//               );
//             });
//           } else if (value is List) {
//             for (var element in value) {
//               if (element is Map) {
//                 element.forEach((subKey, subValue) {
//                   widgets.add(
//                     ListTile(
//                       title: Text('$subKey: $subValue'),
//                     ),
//                   );
//                 });
//               } else {
//                 widgets.add(
//                   ListTile(
//                     title: Text('$element'),
//                   ),
//                 );
//               }
//             }
//           } else {
//             widgets.add(
//               ListTile(
//                 title: Text('$value'),
//               ),
//             );
//           }
//         } else {
//           // Continue searching in nested structures
//           widgets.addAll(_buildList(value, fieldsToDisplay));
//         }
//       });
//     } else if (data is List) {
//       for (var element in data) {
//         widgets.addAll(_buildList(element, fieldsToDisplay));
//       }
//     }
//     return widgets;
//   }
// }