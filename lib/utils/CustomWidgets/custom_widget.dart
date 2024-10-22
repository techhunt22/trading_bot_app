import 'package:flutter/material.dart';

import '../../Constants/color_constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: white,width: 0.5)),
            ),
          ),
          SizedBox(width: screenWidth * 0.08),
          // Space between the Container and Text widgets
          Text("OR",
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w400,
                  fontSize: screenHeight * 0.020)),
          SizedBox(width: screenWidth * 0.08),
          // Space between the Text and Container widgets
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: white,width: 0.5)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class FaceBookWidget extends StatelessWidget {
//   final double height;
//   final double width;
//   final VoidCallback onPressed;
//
//   const FaceBookWidget(
//       {super.key,
//       required this.height,
//       required this.width,
//       required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//         width:width,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: fbblue
//           ),
//           onPressed: onPressed,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // Center the content horizontally
//             children: <Widget>[
//               Image.asset("assets/icons/facebookicon.png"),
//               // Use the icon of your choice
//               SizedBox(width: MediaQuery.of(context).size.width*0.08),
//               // Give some spacing between the icon and the text
//               Text('Login with Facebook', style: TextStyle(color: white),),
//
//               // Replace 'Button Text' with your actual text
//             ],
//           )),
//     );
//   }
// }
//
// class GoogleWidget extends StatelessWidget {
//   final double height;
//   final double width;
//   final VoidCallback onPressed;
//
//   const GoogleWidget(
//       {super.key,
//       required this.height,
//       required this.width,
//       required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//         width:width,
//       child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white
//           ),
//           onPressed: onPressed,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             // Center the content horizontally
//             children: <Widget>[
//               Image.asset("assets/icons/googleicon.png"),
//               // Use the icon of your choice
//               SizedBox(width: MediaQuery.of(context).size.width*0.08),
//               // Give some spacing between the icon and the text
//               Text('Login with Google', style: TextStyle(color: mainblack),),
//
//               // Replace 'Button Text' with your actual text
//             ],
//           )),
//     );
//   }
// }
