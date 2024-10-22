import 'package:flutter/material.dart';

import '../../Constants/color_constants.dart';


class ProfileWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onTap;
  const ProfileWidget({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: Text(text, style: const TextStyle(color: white,fontSize: 18),),

          trailing: Container(
            padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  color: primarycolor
                )
              ),
              child: const Icon(Icons.arrow_forward_ios, color: primarycolor,size: 10,)),
        ),
      ),
    );
  }
}
