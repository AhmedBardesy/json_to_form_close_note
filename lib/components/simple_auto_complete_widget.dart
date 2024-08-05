import 'dart:developer';

import 'package:flutter/material.dart';

class AutoCompleteWidget extends StatelessWidget {
  final List<String>? options;
  final Function? onChanged;
  final int position;
  AutoCompleteWidget({
    required this.options,
    this.onChanged,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    String extractTextAfterLastSpace(String text) {
      final lastSpaceIndex = text.lastIndexOf(' ');
      if (lastSpaceIndex != -1 && lastSpaceIndex < text.length - 1) {
        return text.substring(lastSpaceIndex + 1);
      }
      return '';
    }

    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        log('textEditingValue.text: ${textEditingValue.text}');
        if (options != null && options!.isNotEmpty) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable<String>.empty();
          }
          if (textEditingValue.text.split(' ').length > 1) {
            final String textAfterLastSpace =
                extractTextAfterLastSpace(textEditingValue.text);
            if (textAfterLastSpace.isNotEmpty) {
              return options!.where((option) => option
                  .toLowerCase()
                  .contains(textAfterLastSpace.toLowerCase()));
            }
          } else {
            return options!.where((option) => option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          }
        }
        return const Iterable<String>.empty();
      },
      onSelected: (String selection) {
        if (onChanged != null) {
          onChanged!(position, selection);
        }
      },
    );
  }
}
