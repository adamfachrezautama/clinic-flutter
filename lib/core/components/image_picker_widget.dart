import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../assets/assets.gen.dart';
import 'spaces.dart';

class ImagePickerWidget extends StatefulWidget {
  final String label;
  final void Function(XFile? file) onChanged;
  final bool showLabel;
  final String? imageUrl;

  const ImagePickerWidget({
    super.key,
    required this.label,
    required this.onChanged,
    this.showLabel = true,
    this.imageUrl,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String? imagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
        widget.onChanged(pickedFile);
      } else {
        debugPrint('No image selected.');
        widget.onChanged(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SpaceHeight(12.0),
        ],
        GestureDetector(
          onTap: _pickImage,
          child: SizedBox(
            width: 80.0,
            height: 80.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: imagePath != null
                  ? Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
              )
                  : widget.imageUrl != null
                  ? Image.network(
                "${dotenv.env["BASE_URL"]}${widget.imageUrl}",
                fit: BoxFit.cover,
              )
                  : Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.black.withOpacity(0.05),
                child: Assets.icons.image.svg(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
