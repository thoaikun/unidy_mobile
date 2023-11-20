import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EditCampaignViewModel extends ChangeNotifier {
  final List<File> _files = [];

  List<File> get files => _files;

  void addFile(File file) {
    _files.add(file);
    notifyListeners();
  }

  void removeFile(File file) {
    _files.remove(file);
    notifyListeners();
  }

  void handleAddImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for (String? path in result.paths) {
        if (path != null) {
          addFile(File(path));
        }
      }
    }
  }
}