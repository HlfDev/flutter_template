import 'package:flutter/material.dart';

class DSLabel extends StatelessWidget {
  final String text;
  final TextStyle Function(BuildContext context) styleBuilder;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  const DSLabel._(
    this.text, {
    super.key,
    required this.styleBuilder,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  static DSLabel titleLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.displaySmall!,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
    );
  }

  static DSLabel titleMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.headlineMedium!,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
    );
  }

  static DSLabel bodyLarge(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.bodyLarge!,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
    );
  }

  static DSLabel bodyMedium(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.bodyMedium!,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
    );
  }

  static DSLabel bodySmall(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.bodySmall!,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      fontWeight: fontWeight,
    );
  }

  static DSLabel headline(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return DSLabel._(
      text,
      key: key,
      styleBuilder: (context) => Theme.of(context).textTheme.displayMedium!,
      color: color,
      textAlign: textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = styleBuilder.call(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle.copyWith(color: color, fontWeight: fontWeight),
    );
  }
}
