import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AutoCompleteWidget extends StatefulWidget {
  final Function? onChanged;
  final int position;
  final Map decoration;
  final Map item;
  final Function(Map errorMessage)? errorMessages;
  final Future<List<String>> Function(Map ref)? fetchOptions;

  AutoCompleteWidget({
    this.onChanged,
    required this.position,
    required this.decoration,
    required this.item,
    this.fetchOptions,
    this.errorMessages,
  });

  @override
  State<AutoCompleteWidget> createState() => _AutoCompleteWidgetState();
}

class _AutoCompleteWidgetState extends State<AutoCompleteWidget> {
  final StringTagController stringTagController = StringTagController();
  List<String> options = <String>[];

  @override
  Widget build(BuildContext context) {
    List<String> lowerTagsListNames =
        options.map((e) => e.toLowerCase()).toList();
    log('bbuuiiild item : ${stringTagController.getTags} | options : $options');

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
        optionsViewBuilder: (context, onSelected, options) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Wrap(
                            children: options.map((String option) {
                              bool disable =
                                  stringTagController.getTags!.contains(option)
                                      ? true
                                      : false;
                              log('disable : $disable stringTagController.getTags : ${stringTagController.getTags}');
                              return TextButton(
                                onPressed: () {
                                  onSelected(option);
                                  stringTagController.onTagSubmitted(option);
                                  var tags = stringTagController.getTags;
                                  String savedTags = tags!.join(' ');
                                  widget.item['value'] = savedTags;
                                  widget.onChanged!(widget.position, savedTags);

                                  setState(() {});
                                  log('Autocomplete widget onpressed : $option ,stringTagController tags : ${stringTagController.getTags}');
                                },
                                child: OptionBuiderItem(
                                  color: disable ? Colors.grey : Colors.black,
                                  option: option,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          // textEditingController.text = widget.item['value'] ?? '';
          return TextFieldTags<String>(
            textfieldTagsController: stringTagController,
            textEditingController: textEditingController,
            focusNode: focusNode,
            initialTags: widget.item['value'] != null
                ? widget.item['value'].split(' ').toList()
                : [],
            validator: (String tag) {
              log('Autocomplete widget validator options : $options');
              log('validator tag  $tag');
              // log('validator tagsList  $tagsListNames');
              String lowerTag = tag.toLowerCase();

              if (!options
                  .map((e) => e.toLowerCase())
                  .toList()
                  .contains(lowerTag)) {
                // showSnackBar('Tag not allowed', context);
                widget.errorMessages!(
                    {'key': widget.item['key'], 'error': 'Tag not allowed'});
                return '';
              }
              if (stringTagController.getTags!.any(
                  (existingTag) => existingTag.toLowerCase() == lowerTag)) {
                // showSnackBar('You\'ve already entered this tag', context);
                widget.errorMessages!({
                  'key': widget.item['key'],
                  'error': 'You\'ve already entered this tag'
                });
                return '';
              }

              return null;
            },
            textSeparators: const [',', ' '],
            letterCase: LetterCase.normal,
            inputFieldBuilder: (context, inputFieldValues) {
              log('inputFieldValues.tags.isEmpty : ${inputFieldValues.tags.isEmpty}');
              return TextField(
                controller: inputFieldValues.textEditingController,
                focusNode: inputFieldValues.focusNode,
                decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    hintText:
                        inputFieldValues.tags.isNotEmpty ? '' : "Add Tags !",
                    hintStyle: const TextStyle(color: Colors.black),
                    errorText: inputFieldValues.error,
                    prefixIconConstraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.74),
                    prefixIcon: inputFieldValues.tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: inputFieldValues.tagScrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: inputFieldValues.tags.map((tag) {
                                log('tagVVV: $tag');
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          tag,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 4.0),
                                        InkWell(
                                          child: const Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: Color.fromARGB(
                                                255, 233, 233, 233),
                                          ),
                                          onTap: () {
                                            inputFieldValues.onTagRemoved(tag);
                                            var tags =
                                                stringTagController.getTags;
                                            String savedTags = tags!.join(' ');
                                            widget.item['value'] = savedTags;
                                            widget.onChanged!(
                                                widget.position, savedTags);
                                            setState(() {});
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : null),
                onChanged: (text) {
                  // widget.item['value'] = value;
                  // widget.onChanged!(widget.position, value);
                  // setState(() {});
                  log('Autocomplete widget onChangedd text: $text || lowerTagsListNames $lowerTagsListNames');
                  String lowerText = text.toLowerCase();
                  log('on changed text $text');
                  if (lowerText.split(' ').length > 1 &&
                      !options
                          .map((e) => e.toLowerCase())
                          .toList()
                          .contains(lowerText.trim())) {
                    inputFieldValues.textEditingController.clear();
                    widget.errorMessages!({
                      'key': widget.item['key'],
                      'error': 'Tag not allowed'
                    });
                    // showSnackBar('Tag not allowed !!', context);
                  }
                  if (lowerText.split(' ').length > 1 ||
                      options
                          .map((e) => e.toLowerCase())
                          .toList()
                          .contains(lowerText.trim())) {
                    if (options
                        .map((e) => e.toLowerCase())
                        .toList()
                        .contains(lowerText.trim())) {
                      stringTagController.onTagSubmitted(lowerText.trim());

                      inputFieldValues.textEditingController.clear();
                      log('Autocomplete widget ${stringTagController.getTags}');
                      var tags = stringTagController.getTags;
                      String savedTags = tags!.join(' ');
                      widget.item['value'] = savedTags;
                      widget.onChanged!(widget.position, savedTags);
                    }
                  }
                },
                onSubmitted: (value) {
                  inputFieldValues.textEditingController.clear();
                  log('Autocomplete widget onSubmitted : $value');
                  setState(() {});
                },
              );
            },
          );
        },
        optionsBuilder: (TextEditingValue textEditingValue) async {
          String ref = widget.item['ref'];
          log('ref $ref');
          final String textAfterLastSpace =
              extractTextAfterLastSpace(textEditingValue.text);
          options = await widget
              .fetchOptions!({'ref': ref, 'text': textAfterLastSpace});
          log('options $options');
          if (options.isNotEmpty) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            final String textAfterLastSpace =
                extractTextAfterLastSpace(textEditingValue.text);
            if (textAfterLastSpace.isNotEmpty) {
              return options.where((option) => option
                  .toLowerCase()
                  .contains(textAfterLastSpace.toLowerCase()));
            }
          }
          return const Iterable<String>.empty();
        },
        onSelected: (String selection) {
          log('Autocomplete widget onSelected: $selection');
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

class OptionBuiderItem extends StatelessWidget {
  const OptionBuiderItem({
    required this.option,
    required this.color,
  });
  final String option;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: color),
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Text(
        option,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

List<String> topRelatedTagsList = [];
