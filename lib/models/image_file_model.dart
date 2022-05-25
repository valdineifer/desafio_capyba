import 'dart:io';

import 'package:flutter/material.dart';

class ImageFileModel extends ChangeNotifier {
  late File _imageFile;
  File get imageFile => _imageFile;
  set imageFile(value) => value;
}
