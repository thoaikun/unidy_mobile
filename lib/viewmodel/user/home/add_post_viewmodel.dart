import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:unidy_mobile/models/post_emotional_model.dart';
import 'package:unidy_mobile/services/post_service.dart';
import 'package:http_parser/http_parser.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/validation_util.dart';

class AddPostViewModel extends ChangeNotifier {
  final PostService _postService = GetIt.instance<PostService>();

  final List<File> _files = [];
  final TextEditingController _contentController = TextEditingController();
  PostEmotionalData? _postEmotionalData;
  bool isLoading = false;
  String? contentError;

  List<File> get files => _files;
  TextEditingController get contentController => _contentController;
  PostEmotionalData? get postEmotionalData => _postEmotionalData;

  AddPostViewModel() {
    _contentController.addListener(() {
      setContentError(null);
    });
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setContentError(String? value) {
    contentError = value;
    notifyListeners();
  }

  void addEmotional(EPostEmotional ePostEmotional) {
    print('changing emotional');
    _postEmotionalData = ePostEmotionalMap[ePostEmotional]!;
    notifyListeners();
  }

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

  Future<void> handleCreatePost() async {
    setLoading(true);

    try {
      Validation.validateInput(_contentController.text, 'input');
      Map<String, String> payload = {
        'content': _contentController.text,
        'status': _postEmotionalData?.title ?? ePostEmotionalMap[EPostEmotional.happy]!.title
      };

      List<MultipartFile> files = await _convertToMultipartFiles(_files);
      return _postService.create(payload, files);
    }
    catch (error) {
      if (error is ValidationException) {
        setContentError(error.message);
      }
      rethrow;
    }
  }

  void cleanInput() {
    _contentController.clear();
    _files.clear();
    _postEmotionalData = null;
    notifyListeners();
  }

  Future<List<MultipartFile>> _convertToMultipartFiles(List<File> files) async {
    List<MultipartFile> multipartFiles = [];
    for (File file in files) {
      MultipartFile multipartFile = await MultipartFile.fromPath(
          'listImageFile',
          file.path,
          contentType: MediaType('image', file.path.substring(file.path.lastIndexOf('.') + 1))
      );
      multipartFiles.add(multipartFile);
    }
    return multipartFiles;
  }
}