import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:design_system/tokens/ds_sizes.dart';

class DSLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const DSLabel._({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    required this.textAlign,
    this.maxLines,
    this.overflow,
  });

  const DSLabel.titleLarge({
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
         fontSize: DSSizes.fontTitle,
         fontWeight: fontWeight ?? FontWeight.bold,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.titleMedium({
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
         fontSize: DSSizes.fontXL,
         fontWeight: fontWeight ?? FontWeight.w600,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.bodyLarge({
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
         fontSize: DSSizes.fontL,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.bodyMedium({
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
         fontSize: DSSizes.fontM,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.bodySmall({
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
         fontSize: DSSizes.fontS,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.caption({
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
         fontSize: DSSizes.fontXS,
         fontWeight: fontWeight ?? FontWeight.normal,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.headline({
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
         fontSize: DSSizes.fontHeadline,
         fontWeight: fontWeight ?? FontWeight.bold,
         color: color,
         textAlign: textAlign ?? TextAlign.start,
         maxLines: maxLines,
         overflow: overflow,
       );

  const DSLabel.display({
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
         fontSize: DSSizes.fontDisplay,
         fontWeight: fontWeight ?? FontWeight.bold,
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
