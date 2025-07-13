import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const Label._({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    required this.textAlign,
    this.maxLines,
    this.overflow,
  });

  const Label.titleLarge({
    Key? key,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) : this._(
         key: key,
         text: text,
         fontSize: 22,
         fontWeight: fontWeight ?? FontWeight.bold,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const Label.titleMedium({
    Key? key,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) : this._(
         key: key,
         text: text,
         fontSize: 18,
         fontWeight: fontWeight ?? FontWeight.w600,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const Label.bodyLarge({
    Key? key,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) : this._(
         key: key,
         text: text,
         fontSize: 16,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const Label.bodyMedium({
    Key? key,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) : this._(
         key: key,
         text: text,
         fontSize: 14,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const Label.bodySmall({
    Key? key,
    required String text,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) : this._(
         key: key,
         text: text,
         fontSize: 12,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context).style;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? defaultTextStyle.color,
      ),
    );
  }
}
