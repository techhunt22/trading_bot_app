import 'package:flutter/material.dart';



const Color  background = Color(0xff202133);
const Color  primarycolor = Color(0xff344675);
const Color  darkbackground = Color(0xff202133);
const Color purple = Color(0xff8A2BE2);
const Color transparent = Colors.transparent;

const Color  white = Colors.white;
const Color  red = Colors.red;

final Color greylight =  const Color(0xffFFFFFF).withOpacity(0.65);
const Color grey =  Colors.grey;



LinearGradient buttonlineargradient() {
  return const LinearGradient(
    colors: [
      Color(0xff4C2180),
      Color(0xff8A2BE2)
    ],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}

