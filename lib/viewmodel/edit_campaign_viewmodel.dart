import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/models/volunteer_category_model.dart';
import 'package:unidy_mobile/services/campaign_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';

class EditCampaignViewModel extends ChangeNotifier {
  final CampaignService _campaignService = GetIt.instance<CampaignService>();
  final void Function(String content) showSnackBar;

  final List<File> _files = [];
  List<VolunteerCategory> _selectedCategories = [];
  List<String> _hagTags = [];
  bool isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _openFormTimeController = TextEditingController();
  final TextEditingController _closeFormTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _budgetTargetController = TextEditingController();
  final TextEditingController _targetVolunteerController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();

  final BehaviorSubject<String> _titleSubject = BehaviorSubject();
  final BehaviorSubject<String> _descriptionSubject = BehaviorSubject();
  final BehaviorSubject<String> _openFormTimeSubject = BehaviorSubject();
  final BehaviorSubject<String> _closeFormTimeSubject = BehaviorSubject();
  final BehaviorSubject<String> _locationSubject = BehaviorSubject();
  final BehaviorSubject<String> _budgetTargetSubject = BehaviorSubject();
  final BehaviorSubject<String> _targetVolunteerSubject = BehaviorSubject();
  final BehaviorSubject<String> _startDateSubject = BehaviorSubject();

  String? titleError;
  String? descriptionError;
  String? openFormTimeError;
  String? closeFormTimeError;
  String? locationError;
  String? startDateError;

  List<File> get files => _files;
  List<VolunteerCategory> get selectedCategories => _selectedCategories;
  List<String> get hagTags => _hagTags;
  TextEditingController get titleController => _titleController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get openFormTimeController => _openFormTimeController;
  TextEditingController get closeFormTimeController => _closeFormTimeController;
  TextEditingController get locationController => _locationController;
  TextEditingController get budgetTargetController => _budgetTargetController;
  TextEditingController get targetVolunteerController => _targetVolunteerController;
  TextEditingController get startDateController => _startDateController;

  EditCampaignViewModel({
    required this.showSnackBar
  }) {
    titleController.addListener(() => _setTitleError(null));
    descriptionController.addListener(() => _setDescriptionError(null));
    openFormTimeController.addListener(() => _setOpenFormTimeError(null));
    closeFormTimeController.addListener(() => _setCloseFormTimeError(null));
    locationController.addListener(() => _setLocationError(null));
    startDateController.addListener(() => _setStartDateError(null));

    verifyForm();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setTitleError(String? value) {
    titleError = value;
    notifyListeners();
  }

  void _setDescriptionError(String? value) {
    descriptionError = value;
    notifyListeners();
  }

  void _setOpenFormTimeError(String? value) {
    openFormTimeError = value;
    notifyListeners();
  }

  void _setCloseFormTimeError(String? value) {
    closeFormTimeError = value;
    notifyListeners();
  }

  void _setLocationError(String? value) {
    locationError = value;
    notifyListeners();
  }

  void _setStartDateError(String? value) {
    startDateError = value;
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

  void toggleCategory(bool selected, VolunteerCategory category) {
    if (!selected) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  Map<String, double> initCategoryWeights() {
    Map<String, double> result = {};

    for (VolunteerCategory category in VolunteerCategory.categories) {
      double value;
      if (selectedCategories.contains(category)) {
        value = Random().nextDouble() * (1 - 0.1) + 0.1;
      }
      else {
        value = 0;
      }

      switch(category.key) {
        case VolunteerCategoryKey.education:
          result['education'] = value;
          break;
        case VolunteerCategoryKey.emergencyPreparedness:
          result['emergencyPreparedness'] = value;
          break;
        case VolunteerCategoryKey.environment:
          result['environment'] = value;
          break;
        case VolunteerCategoryKey.health:
          result['healthy'] = value;
          break;
        case VolunteerCategoryKey.helpingNeighbours:
          result['helpOther'] = value;
          break;
        case VolunteerCategoryKey.strengtheningCommunities:
          result['communityType'] = value;
          break;
        case VolunteerCategoryKey.researchWritingEditing:
          result['research'] = value;
          break;
      }
    }
    return result;
  }

  void handleAddHagTag(List<String> hagTags) {
    _hagTags = hagTags;
    notifyListeners();
  }

  void handleRemoveHagTag(String value) {
    _hagTags.remove(value);
    notifyListeners();
  }

  void handleSubmitHagTag(String value) {
    if (value.trim().isNotEmpty) {
      _hagTags = [..._hagTags, value];
      notifyListeners();
    }
  }

  void selectDate(BuildContext context, String type) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      String date = DateFormat('dd/MM/yyyy').format(picked).toString();
      switch (type) {
        case 'openFormTime':
          _openFormTimeController.text = date;
          break;
        case 'closeFormTime':
          _closeFormTimeController.text = date;
          break;
        case 'startDate':
          _startDateController.text = date;
          break;
      }
    }
  }

  void handleConfirm() {
    Sink<String> titleSink = _titleSubject.sink;
    Sink<String> descriptionSink = _descriptionSubject.sink;
    Sink<String> openFormTimeSink = _openFormTimeSubject.sink;
    Sink<String> closeFormTimeSink = _closeFormTimeSubject.sink;
    Sink<String> locationSink = _locationSubject.sink;
    Sink<String> budgetTargetSink = _budgetTargetSubject.sink;
    Sink<String> targetVolunteerSink = _targetVolunteerSubject.sink;
    Sink<String> startDateSink = _startDateSubject.sink;

    titleSink.add(_titleController.text);
    descriptionSink.add(_descriptionController.text);
    openFormTimeSink.add(_openFormTimeController.text);
    closeFormTimeSink.add(_closeFormTimeController.text);
    locationSink.add(_locationController.text);
    budgetTargetSink.add(_budgetTargetController.text);
    targetVolunteerSink.add(_targetVolunteerController.text);
    startDateSink.add(_startDateController.text);
  }

  void verifyForm() {
    Stream<String> titleStream = _titleSubject.stream;
    Stream<String> descriptionStream = _descriptionSubject.stream;
    Stream<String> openFormTimeStream = _openFormTimeSubject.stream;
    Stream<String> closeFormTimeStream = _closeFormTimeSubject.stream;
    Stream<String> locationStream = _locationSubject.stream;
    Stream<String> budgetTargetStream = _budgetTargetSubject.stream;
    Stream<String> targetVolunteerStream = _targetVolunteerSubject.stream;
    Stream<String> startDateStream = _startDateSubject.stream;

    CombineLatestStream.combine8(
      titleStream.transform(ValidationTransformer(validationType: 'campaignTitle')),
      descriptionStream.transform(ValidationTransformer(validationType: 'campaignDescription')),
      openFormTimeStream.transform(ValidationTransformer(validationType: 'campaignOpenFormDate')),
      closeFormTimeStream.transform(ValidationTransformer(validationType: 'campaignCloseFormDate')),
      locationStream.transform(ValidationTransformer(validationType: 'campaignLocation')),
      budgetTargetStream,
      targetVolunteerStream,
      startDateStream.transform(ValidationTransformer(validationType: 'campaignStartDate')),
      (title, description, openFormTime, closeFormTime, location, budgetTarget, targetVolunteer, startDate) {
        openFormTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateFormat('dd/MM/yyyy').parse(openFormTime).toLocal()).toString();
        closeFormTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateFormat('dd/MM/yyyy').parse(closeFormTime).toLocal()).toString();
        startDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateFormat('dd/MM/yyyy').parse(startDate).toLocal()).toString();

        return <String, String>{
          'title': title,
          'description': description,
          'categories': jsonEncode(initCategoryWeights()),
          'status': 'IN_PROGRESS',
          'startDate': openFormTime,
          'endDate': closeFormTime,
          'timeTakePlace': startDate,
          'location': location,
          'budgetTarget': budgetTarget,
          'numberOfVolunteer': targetVolunteer,
          'hagTags': _hagTags.map((hagTag) => '#$hagTag').join(' ')
        };
      }
    )
      .debounceTime(const Duration(milliseconds: 500))
      .listen((payload) {
        setLoading(true);
        // _convertToMultipartFiles()
        //   .then((images) {
        //     return _campaignService.create(payload, images);
        //   })
        //   .then((_) {
        //     showSnackBar.call('Tạo chiến dịch thành công');
        //     // empty all fields
        //     _titleController.clear();
        //     _descriptionController.clear();
        //     _openFormTimeController.clear();
        //     _closeFormTimeController.clear();
        //     _locationController.clear();
        //     _budgetTargetController.clear();
        //     _targetVolunteerController.clear();
        //     _startDateController.clear();
        //     _files.clear();
        //     _selectedCategories.clear();
        //     _hagTags.clear();
        //   })
        //   .catchError(() => showSnackBar.call('Có lỗi xảy ra'))
        //   .whenComplete(() => setLoading(false));
      })
      .onError(_handleError);
  }

  void _handleError(Object error, StackTrace stackTrace) {
    if (error is ValidationException) {
      switch(error.code) {
        case ExceptionErrorCode.invalidCampaignTitle:
          _setTitleError(error.message);
          break;
        case ExceptionErrorCode.invalidCampaignDescription:
          _setDescriptionError(error.message);
          break;
        case ExceptionErrorCode.invalidCampaignOpenFormDate:
          _setOpenFormTimeError(error.message);
          break;
        case ExceptionErrorCode.invalidCampaignCloseFormDate:
          _setCloseFormTimeError(error.message);
          break;
        case ExceptionErrorCode.invalidCampaignLocation:
          _setLocationError(error.message);
          break;
        case ExceptionErrorCode.invalidCampaignStartDate:
          _setStartDateError(error.message);
          break;
        default:
          break;
      }
    }
  }

  Future<List<MultipartFile>> _convertToMultipartFiles() async {
    List<MultipartFile> multipartFiles = [];
    for (File file in _files) {
      MultipartFile multipartFile = await MultipartFile.fromPath(
          'listImageFile',
          file.path,
          contentType: MediaType('image', file.path.substring(file.path.lastIndexOf('.') + 1))
      );
      multipartFiles.add(multipartFile);
    }
    return multipartFiles;
  }

  @override
  void dispose() {
    super.dispose();
    _titleSubject.close();
    _descriptionSubject.close();
    _openFormTimeSubject.close();
    _closeFormTimeSubject.close();
    _locationSubject.close();
    _budgetTargetSubject.close();
    _targetVolunteerSubject.close();
    _startDateSubject.close();
  }
}