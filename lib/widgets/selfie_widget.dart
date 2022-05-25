import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelfieField extends StatefulWidget {
  final Function(File) onTakePicture;

  const SelfieField({required this.onTakePicture, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelfieFieldState();
}

class SelfieFieldState extends State<SelfieField> {
  Image? _image;
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> _pickImage() async {
    _toggleLoading();

    XFile? imageXFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageXFile != null) {
      Uint8List imageBytes = await imageXFile.readAsBytes();

      setState(() {
        _image = Image.memory(imageBytes, fit: BoxFit.cover);
      });

      widget.onTakePicture(File(imageXFile.path));
    }

    _toggleLoading();
  }

  Widget _getWidget() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return _image != null
        ? _image!
        : IconButton(
            onPressed: _pickImage,
            icon: const Icon(
              Icons.camera_front,
              size: 80,
              color: Colors.green,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(color: Colors.grey[200], child: _getWidget())),
      ),
    );
  }
}
