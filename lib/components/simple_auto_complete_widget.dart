import 'package:flutter/material.dart';

class AutoCompleteWidget extends StatelessWidget {
  final Map<String, List>? maapOptions;
  final Function? onChanged;
  final int position;
  final Map decoration;
  final Map item;

  AutoCompleteWidget({
    required this.maapOptions,
    this.onChanged,
    required this.position,
    required this.decoration,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    List<String>? options = List<String>.from(maapOptions![item['key']] ?? []);
    ;
    String extractTextAfterLastSpace(String text) {
      final lastSpaceIndex = text.lastIndexOf(' ');
      if (lastSpaceIndex != -1 && lastSpaceIndex < text.length - 1) {
        return text.substring(lastSpaceIndex + 1);
      }
      return text;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Autocomplete<String>(
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          textEditingController.text = item['value'] ?? '';
          return TextField(
            onChanged: (value) {
              item['value'] = value;
              onChanged!(position, value);
            },
            controller: textEditingController,
            decoration: item['decoration'] ??
                decoration[item['key']] ??
                InputDecoration(
                  hintText: item['placeholder'] ?? "",
                  helperText: item['helpText'] ?? "",
                ),
            focusNode: focusNode,
            onSubmitted: (value) {
              item['value'] = value;
              onChanged!(position, value);
            },
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (options != null && options!.isNotEmpty) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            final String textAfterLastSpace =
                extractTextAfterLastSpace(textEditingValue.text);
            if (textAfterLastSpace.isNotEmpty) {
              return options!.where((option) => option
                  .toLowerCase()
                  .contains(textAfterLastSpace.toLowerCase()));
            }
          }
          return const Iterable<String>.empty();
        },
        onSelected: (String selection) {
          final textEditingController = TextEditingController();
          final previousText = extractTextBeforeLastSpace(item['value']);
          final newText =
              previousText.isNotEmpty ? '$previousText $selection' : selection;
          item['value'] = newText;
          onChanged!(position, newText);
          textEditingController.text = newText;
          textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length),
          );
        },
      ),
    );
  }
}

String extractTextBeforeLastSpace(String text) {
  final lastSpaceIndex = text.lastIndexOf(' ');
  if (lastSpaceIndex != -1) {
    return text.substring(0, lastSpaceIndex);
  }
  return '';
}
