import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AddPostController extends ChangeNotifier {
  final List<File> _files = [];
  final TextEditingController _contentController = TextEditingController();
  final BehaviorSubject<String> contentSubject = BehaviorSubject<String>();

  AddPostController();

  List<File> get files => _files;
  TextEditingController get contentController => _contentController;

  void addFile(File file) {
    _files.add(file);
    notifyListeners();
  }

  void removeFile(File file) {
    _files.remove(file);

    notifyListeners();
  }

  void handleCancel() {
    files.clear();
    contentController.clear();
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