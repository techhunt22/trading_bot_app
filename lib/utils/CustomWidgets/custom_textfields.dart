import 'package:flutter/material.dart';
import 'package:tradingapp_bot/constants/font_size.dart';

import '../../Constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final Color fillColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction action;
  final Color textColor;
  final String? Function(String?)? validator;
  final String? text;
  final void Function(String)?  onchanged;
  final String hinttext;
  final bool? titleon;
  final bool readonly;

  const CustomTextField({
    super.key,
    required this.fillColor,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    required this.textColor,
    required this.action,
    this.text,
    required this.hinttext,
     this.titleon, required this.readonly, this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleon == true
            ? Text(
                text!,
                style: const TextStyle(
                    fontSize: titlesmall,
                    fontWeight: FontWeight.w400,
                    color: white),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: action,
          onChanged: onchanged,
          cursorColor: white,
          validator: validator,
          readOnly: readonly,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,

            fillColor: fillColor,
            hintText: hinttext,
            hintStyle: TextStyle(
              color: greylight,
              fontSize: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: purple, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final Color fillColor;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color textColor;
  final TextInputType keyboardType;
  final String text;
  final String hinttext;

  const CustomPasswordField({
    super.key,
    required this.fillColor,
    required this.controller,
    required this.validator,
    required this.textColor,
    required this.text,
    required this.keyboardType,
    required this.hinttext,
  });

  @override
  CustomPasswordFieldState createState() => CustomPasswordFieldState();
}

class CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: const TextStyle(
              fontSize: titlesmall, fontWeight: FontWeight.w400, color: white),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          cursorColor: white,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hinttext,
            hintStyle: TextStyle(
              color: greylight,
              fontSize: 14,
            ),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: purple, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent, width: 1),
            ),
            suffixIcon: IconButton(
              focusNode: NeverFocusNode(),
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: greylight,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        ),
      ],
    );
  }
}

class NeverFocusNode extends FocusNode {
  @override
  bool get canRequestFocus => false;
}

class CustomTextfield2 extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction action;
  final Color textColor;
  final Icon? icon;

  const CustomTextfield2({
    super.key,
    required this.hintText,
    required this.fillColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.textColor,
    required this.action,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: action,
        style: TextStyle(color: textColor, fontSize: 14),
        cursorColor: white,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: icon,
          // Check if icon is not null before adding

          hintStyle: const TextStyle(color: grey, fontSize: 14),
          filled: true,
          fillColor: fillColor,

          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          // Use UnderlineInputBorder
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: white, width: 1.0), // Customize as needed
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide:
                BorderSide(color: white, width: 1.0), // Customize as needed
          ),
        ),
      ),
    );
  }
}

class CardTextField extends StatelessWidget {
  final String hintText;
  final String text;
  final Color fillColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction action;
  final Color textColor;

  const CardTextField({
    super.key,
    required this.hintText,
    required this.fillColor,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.textColor,
    required this.action,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            text,
            style: const TextStyle(color: white, fontSize: 14),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: action,
          style: TextStyle(color: textColor, fontSize: 14),
          cursorColor: white,
          decoration: InputDecoration(
            hintText: hintText,

            hintStyle: const TextStyle(color: grey, fontSize: 14),
            filled: true,
            fillColor: fillColor,

            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            // Use UnderlineInputBorder
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide:
                  BorderSide(color: white, width: 1.0), // Customize as needed
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide:
                  BorderSide(color: white, width: 1.0), // Customize as needed
            ),
          ),
        ),
      ],
    );
  }
}
