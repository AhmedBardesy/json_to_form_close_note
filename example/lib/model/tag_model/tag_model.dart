// import 'package:hive/hive.dart';

// part 'tag_model.g.dart';

// @HiveType(typeId: 2)
class tag_model {
  int tagid;
  String type;
  String name;
  List<String> relatedtag;

  tag_model({
    required this.tagid,
    required this.type,
    required this.name,
    required this.relatedtag,
  });
}

List<tag_model> tagBox = [
  tag_model(
    tagid: 1,
    name: 'xx',
    type: 'eval',
    relatedtag: ['f_1', 'p_2'],
  ),
  tag_model(
    tagid: 1,
    name: 'yy',
    type: 'place',
    relatedtag: ['o_2', 's_1'],
  ),
  tag_model(
    tagid: 1,
    name: 'zz',
    type: 'org',
    relatedtag: ['f_2'],
  ),
  tag_model(
    tagid: 1,
    name: 'ffY',
    type: 'sop',
    relatedtag: [],
  ),
  tag_model(
    tagid: 1,
    name: 'rrX',
    type: 'field',
    relatedtag: [],
  ),
  tag_model(
    tagid: 2,
    name: 'TTX',
    type: 'place',
    relatedtag: [],
  ),
  tag_model(
    tagid: 2,
    name: 'NNY',
    type: 'org',
    relatedtag: [],
  ),
  tag_model(
    tagid: 2,
    name: 'gh',
    type: 'eval',
    relatedtag: [],
  ),
  tag_model(
    tagid: 3,
    name: 'gahmed',
    type: 'eval',
    relatedtag: [],
  ),
  tag_model(
    tagid: 2,
    name: 'ww',
    type: 'sop',
    relatedtag: [],
  ),
  tag_model(
    tagid: 2,
    name: 'dd',
    type: 'field',
    relatedtag: [],
  ),
];

// class TagController {
//   static Future<void> getTagList() async {
//     tagBox.put(
//       1,
//       tag_model(
//         tagid: 1,
//         name: 'xx',
//         type: 'eval',
//         relatedtag: ['f_1', 'p_2'],
//       ),
//     );
//     tagBox.put(
//       2,
//       tag_model(
//         tagid: 1,
//         name: 'yy',
//         type: 'place',
//         relatedtag: ['o_2', 's_1'],
//       ),
//     );

//     tagBox.put(
//       3,
//       tag_model(
//         tagid: 1,
//         name: 'zz',
//         type: 'org',
//         relatedtag: ['f_2'],
//       ),
//     );

//     tagBox.put(
//       4,
//       tag_model(
//         tagid: 1,
//         name: 'ffY',
//         type: 'sop',
//         relatedtag: [],
//       ),
//     );

//     tagBox.put(
//       5,
//       tag_model(
//         tagid: 1,
//         name: 'rrX',
//         type: 'field',
//         relatedtag: [],
//       ),
//     );

//     tagBox.put(
//       6,
//       tag_model(
//         tagid: 2,
//         name: 'TTX',
//         type: 'place',
//         relatedtag: [],
//       ),
//     );
//     tagBox.put(
//       7,
//       tag_model(
//         tagid: 2,
//         name: 'NNY',
//         type: 'org',
//         relatedtag: [],
//       ),
//     );
//     tagBox.put(
//       8,
//       tag_model(
//         tagid: 2,
//         name: 'gh',
//         type: 'eval',
//         relatedtag: [], 
//       ),
//     );
//     tagBox.put(
//       9,
//       tag_model(
//         tagid: 2,
//         name: 'ww',
//         type: 'sop',
//         relatedtag: [],
//       ),
//     );
//     tagBox.put(
//       10,
//       tag_model(
//         tagid: 2,
//         name: 'dd',
//         type: 'field',
//         relatedtag: [],
//       ),
//     );
//   }
// }

// late Box<tag_model> tagBox;