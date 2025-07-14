import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Labels', type: DSLabel)
Widget labelUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8.0,
      children: [
        DSLabel.titleLarge(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Title Large Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        DSLabel.titleMedium(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Title Medium Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        DSLabel.bodyLarge(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Body Large Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        DSLabel.bodyMedium(
          text: context.knobs.string(
            label: 'Label Text',
            initialValue: 'Body Medium Label',
          ),
          color: context.knobs.colorOrNull(label: 'Color'),
        ),
        DSLabel.bodySmall(
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
