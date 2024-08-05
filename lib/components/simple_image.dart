import 'package:flutter/material.dart';

class SimpleImage extends StatefulWidget {
  final Map item;
  // final Function onChange;
  final int position;
  final Function? imageTap; // Add this line

  const SimpleImage({
    Key? key,
    required this.item,
    // required this.onChange,
    required this.position,
    this.imageTap, // Add this line
  }) : super(key: key);

  @override
  _SimpleImageState createState() => _SimpleImageState();
}

class _SimpleImageState extends State<SimpleImage> {
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    imagePath = widget.item['value'] ?? '';
  }

  void _handleTap() {
    widget.imageTap?.call({
      'action': 'Capture',
      'key': widget.item['key'],
      'type': widget.item['type'],
      'value': imagePath
    });
  }

  void _handleDoubleTap() {
    widget.imageTap?.call({
      'action': 'Update',
      'key': widget.item['key'],
      'type': widget.item['type'],
      'value': imagePath
    });
  }

  void _handleLongPress() {
    widget.imageTap?.call({
      'action': 'Delete',
      'key': widget.item['key'],
      'type': widget.item['type'],
      'value': imagePath
    });
  }

  // Future<String> _navigateAndSelectImage() async {
  //   // Placeholder for the navigation logic
  //   return "new_image_path";
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.item['label'] ?? '', style: TextStyle(fontSize: 16)),
          GestureDetector(
            onTap: _handleTap,
            onDoubleTap: _handleDoubleTap,
            onLongPress: _handleLongPress,
            child: imagePath.isEmpty
                ? Image.asset(
                    'assets/add_image.png') // Display the selected image
                : Placeholder(fallbackHeight: 200), // Placeholder for no image
          ),
        ],
      ),
    );
  }
}
