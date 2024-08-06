import 'dart:convert';
import 'dart:developer';

import 'package:example/model/tag_model/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:json_to_form/json_schema.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String form = json.encode({
    'fields': [
      {
        "key": "image2",
        "type": "Image",
        "label": "Profile Picture",
        "value": ""
      },
      {
        'key': 'input1',
        'type': 'Input',
        'label': 'Username',
        'placeholder': "Enter Your Username",
        'required': true
      },
      {
        'key': 'autocomplete1',
        'type': 'AutoComplete',
        'label': 'Check AutoComplete',
        'ref': 'tagBox:eval'
      },
      {
        'key': 'autocomplete2',
        'type': 'AutoComplete',
        'label': 'Check AutoComplete',
        'ref': 'tagBox:sop'
      },
      {
        "key": "image1",
        "type": "Image",
        "label": "Profile Picture",
        "value": ""
      },
      {
        'key': 'password1',
        'type': 'Password',
        'label': 'Password',
        'required': true
      },
    ]
  });
  dynamic response;

  Map decorations = {
    'input1': const InputDecoration(
      prefixIcon: Icon(Icons.account_box),
      border: OutlineInputBorder(),
    ),
    'password1': const InputDecoration(
        prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
    'autocomplete1': const InputDecoration(
        prefixIcon: Icon(Icons.autofps_select_rounded),
        border: OutlineInputBorder()),
    'autocomplete2': const InputDecoration(
        prefixIcon: Icon(Icons.av_timer_sharp), border: OutlineInputBorder()),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            const Text(
              "Login Form",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            JsonSchema(
              errorMessage: (p0) {
                showSnackBar(p0['error'], context);
                log('error: $p0');
              },
              fetchOptions: fetchOptionsItems,
              decorations: decorations,
              form: form, // savedForm,
              onChanged: (dynamic response) {
                this.response = response;
                savedForm = jsonEncode(response);
                log('Saved form: $savedForm');
                log('response: $response');
              },
              actionSave: (data) {
                log('response data is: $data');
              },
              imageTap: (data) {
                log('data: $data');
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              buttonSave: Container(
                height: 40.0,
                color: Colors.blueAccent,
                child: const Center(
                  child: Text("Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

String savedForm = '';
// Future<List<String>> fetchOptions(Map data) async {
//   // Simulate fetching data from a data source based on the ref
//   // await Future.delayed(Duration(seconds: 1)); // Simulating network delay

//   // Split the ref to get the table name and type
//   String ref = data['ref'];
//   String text = data['text'];
//   String optionTableName = ref.split(':').first;
//   String optionTableType = ref.split(':').last;

//   List<String> options = [];

//   // Switch case based on table name
//   switch (optionTableName) {
//     case 'tagBox':
//       // Nested switch case based on type
//       switch (optionTableType) {
//         case 'eval':
//           options = tagBox
//               .where((element) => element.type == 'eval')
//               .map((e) => e.name)
//               .toList();
//           break;
//         case 'sop':
//           options = tagBox
//               .where((element) => element.type == 'sop')
//               .map((e) => e.name)
//               .toList();
//           break;
//         case 'place':
//           options = tagBox
//               .where((element) => element.type == 'place')
//               .map((e) => e.name)
//               .toList();
//           break;
//         case 'org':
//           options = tagBox
//               .where((element) => element.type == 'org')
//               .map((e) => e.name)
//               .toList();
//           break;
//         case 'field':
//           options = tagBox
//               .where((element) => element.type == 'field')
//               .map((e) => e.name)
//               .toList();
//           break;
//         default:
//           options = []; // Return an empty list if type does not match
//           break;
//       }
//       break;
//     default:
//       options = []; // Return an empty list if table name does not match
//       break;
//   }

//   // Filter options based on the text
//   return options
//       .where((name) => name.toLowerCase().contains(text.toLowerCase()))
//       .toList();
// }

Future<List<OptionWithColor>> fetchOptionsItems(
    Map<dynamic, dynamic> data) async {
  String ref = data['ref'];
  String text = data['text'];
  String optionTableName = ref.split(':').first;
  String optionTableType = ref.split(':').last;

  List<OptionWithColor> optionsWithColors = [];

  // Switch case based on table name
  switch (optionTableName) {
    case 'tagBox':
      // Nested switch case based on type
      switch (optionTableType) {
        case 'eval':
          optionsWithColors = tagBox
              .where((element) => element.type == 'eval')
              .map((e) => OptionWithColor(e.name, colorItem(e.name, e.type[0])))
              .toList();
          break;
        case 'sop':
          optionsWithColors = tagBox
              .where((element) => element.type == 'sop')
              .map((e) => OptionWithColor(e.name, colorItem(e.name, e.type[0])))
              .toList();
          break;
        case 'place':
          optionsWithColors = tagBox
              .where((element) => element.type == 'place')
              .map((e) => OptionWithColor(e.name, colorItem(e.name, e.type[0])))
              .toList();
          break;
        case 'org':
          optionsWithColors = tagBox
              .where((element) => element.type == 'org')
              .map((e) => OptionWithColor(e.name, colorItem(e.name, e.type[0])))
              .toList();
          break;
        case 'field':
          optionsWithColors = tagBox
              .where((element) => element.type == 'field')
              .map((e) => OptionWithColor(e.name, colorItem(e.name, e.type[0])))
              .toList();
          break;
        default:
          optionsWithColors = []; // Return an empty list if type does not match
          break;
      }
      break;
    default:
      optionsWithColors =
          []; // Return an empty list if table name does not match
      break;
  }

  // Filter options based on the text
  return optionsWithColors
      .where(
          (option) => option.option.toLowerCase().contains(text.toLowerCase()))
      .toList();
}

Color colorItem(String tag, currenttagid) {
  // var currenttagid =
  //     tagList.where((element) => element.name == tag).first.type[0];

  Color optionColor = currenttagid == 'e'
      ? Colors.purple
      : currenttagid == 'p'
          ? Colors.orange
          : currenttagid == 'o'
              ? Colors.yellow
              : currenttagid == 's'
                  ? Colors.red
                  : Colors.green;
  return optionColor;
}

void showSnackBar(String message, BuildContext context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.grey,
    behavior: SnackBarBehavior.floating,
    shape: const StadiumBorder(),
    elevation: 30,
    content: Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
