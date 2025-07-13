import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Labels', type: Label)
Widget labelUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,
      children: [
        Label.titleLarge(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Title Large Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        Label.titleMedium(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Title Medium Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        Label.bodyLarge(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Body Large Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        Label.bodyMedium(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Body Medium Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        Label.bodySmall(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Body Small Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
      ],
    ),
  );
}
