import 'package:flutter/material.dart';

import '../../Constants/color_constants.dart';
import '../../Constants/font_size.dart';

class Textfieldwidget extends StatelessWidget {
  final Map<String, TextEditingController?> controllers;

  final List hinttext = [
    "Event Name",
    "Description",
    "Venue",

    "Address/Location",
    "In Rs",
    "Total number of tickets"
  ];

  Textfieldwidget({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controllers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 30, childAspectRatio: 4),
      itemBuilder: (context, index) {
        var controller = controllers.values.elementAt(index);
        return TextFormField(
          controller: controller,
          cursorColor: white,
          style: const TextStyle(
            color: white,
            fontSize: bodymedium,
          ),
          decoration: InputDecoration(
            hintText: hinttext[index],
            hintStyle: const TextStyle(color: grey),
            filled: true,
            fillColor: darkbackground,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: primarycolor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: primarycolor, width: 1),
            ),
          ),
        );
      },
    );
  }
}
