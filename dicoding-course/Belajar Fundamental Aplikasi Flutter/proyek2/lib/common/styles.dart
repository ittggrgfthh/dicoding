import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color backgroundColor = Color(0xFF395B64);
const Color foregroundColor = Color(0xFFA5C9CA);
const Color itemForegroundColor = Color(0xFFE7F6F2);
const Color textForegroundColor = Color(0xFF042122);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.oswald(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.oswald(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.oswald(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.oswald(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.oswald(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.oswald(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.oswald(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.oswald(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.ubuntu(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.ubuntu(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.ubuntu(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.ubuntu(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.ubuntu(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
