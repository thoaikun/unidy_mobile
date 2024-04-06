import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unidy_mobile/models/user_model.dart';
import 'package:unidy_mobile/services/user_service.dart';
import 'package:unidy_mobile/utils/exception_util.dart';
import 'package:unidy_mobile/utils/stream_transformer.dart';
import 'package:http_parser/http_parser.dart';

class EditProfileViewModel extends ChangeNotifier {
  final BuildContext context;
  final UserService _userService = GetIt.instance<UserService>();
  final Duration debounceTime = const Duration(milliseconds: 500);

  User? _user;
  String? _previewUploadedImagePath;
  bool _loading = false;

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _workplaceController = TextEditingController();

  final BehaviorSubject<String> _dobSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _sexSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _phoneSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _nameSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _jobSubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _workplaceSubject = BehaviorSubject<String>();

  String? dobError;
  String? sexError;
  String? phoneError;
  String? nameError;
  String? jobError;
  String? workplaceError;

  User? get user => _user;
  String? get previewUploadedImagePath => _previewUploadedImagePath;
  bool get loading => _loading;
  TextEditingController get dobController => _dobController;
  TextEditingController get nameController => _nameController;
  TextEditingController get sexController => _sexController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get jobController => _jobController;
  TextEditingController get workPlaceController => _workplaceController;

  EditProfileViewModel(User user, { required this.context }) {
    _nameController.text = user.fullName ?? '';
    _phoneController.text = user.phone ?? '';
    _jobController.text = user.job ?? '';
    _workplaceController.text = user.workLocation ?? '';
    String date = DateFormat('dd/MM/yyyy').format(user.dayOfBirth ?? DateTime.now()).toString();
    _dobController.text = date;

    _dobController.addListener(() => _setDobError(null));
    _sexController.addListener(() => _setSexError(null));
    _phoneController.addListener(() => _setPhoneError(null));
    _nameController.addListener(() => _setNameError(null));
    _jobController.addListener(() => _setJobError(null));
    _workplaceController.addListener(() => _setWorkplaceError(null));

    _user = user;

    verifyUserInfo();
  }

  void _setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void _setPreviewUploadedImage(String? path) {
    _previewUploadedImagePath = path;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void _setDobError(String? error) {
    dobError = error;
    notifyListeners();
  }

  void _setSexError(String? error) {
    sexError = error;
    notifyListeners();
  }

  void _setPhoneError(String? error) {
    phoneError = error;
    notifyListeners();
  }

  void _setNameError(String? error) {
    nameError = error;
    notifyListeners();
  }

  void _setJobError(String? error) {
    jobError = error;
    notifyListeners();
  }

  void _setWorkplaceError(String? error) {
    workplaceError = error;
    notifyListeners();
  }

  void verifyUserInfo() {
    Stream<String> dobStream = _dobSubject.stream;
    Stream<String> sexStream = _sexSubject.stream;
    Stream<String> phoneStream = _phoneSubject.stream;
    Stream<String> nameStream = _nameSubject.stream;
    Stream<String> jobStream = _jobSubject.stream;
    Stream<String> workplaceStream = _workplaceSubject.stream;

    CombineLatestStream.combine5(
      nameStream.transform(ValidationTransformer(validationType: 'name')),
      dobStream.transform(ValidationTransformer(validationType: 'dob')),
      phoneStream.transform(PhoneValidationTransformer()),
      jobStream.transform(ValidationTransformer(validationType: 'job')),
      workplaceStream.transform(ValidationTransformer(validationType: 'workplace')),
      (name, dob, phone, job, workplace) {
        DateTime dateTime = DateFormat('dd/MM/yyyy').parse(dob);

        _user?.fullName = name;
        _user?.dayOfBirth = dateTime;
        _user?.phone = phone;
        _user?.job = job;
        _user?.workLocation = workplace;
        _user?.image = _previewUploadedImagePath;

        return <String, dynamic>{
          "fullName" : name,
          "dayOfBirth" : DateFormat('yyyy-MM-dd').format(dateTime).toString(),
          "phone" : phone,
          "job": job,
          "workLocation": workplace,
        };
      }
    )
      .debounceTime(debounceTime)
      .listen((payload) {
        _setLoading(true);
        Future.delayed(const Duration(seconds: 1))
          .then((_) => _userService.updateProfile(payload))
          .then((_) {
            _setLoading(false);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thành công'),
                  content: const Text('Thông tin tài khoản của bạn đã được cập nhật'),
                  actions: <Widget>[
                    TextButton(
                        child: const Text('Đồng ý'),
                        onPressed: () => Navigator.of(context).pop()
                    ),
                  ],
                );
              },
            );
          })
          .catchError((error) {
            _setLoading(false);
            handleUpdateProfileError(error);
          });
      })
      .onError(handleUpdateProfileError);
  }

  void handleUpdateProfile() {
    Sink<String> dobSink = _dobSubject.sink;
    Sink<String> sexSink = _sexSubject.sink;
    Sink<String> phoneSink = _phoneSubject.sink;
    Sink<String> nameSink = _nameSubject.sink;
    Sink<String> jobSink = _jobSubject.sink;
    Sink<String> workplaceSink = _workplaceSubject.sink;

    dobSink.add(_dobController.text);
    sexSink.add(_sexController.text);
    phoneSink.add(_phoneController.text);
    nameSink.add(_nameController.text);
    jobSink.add(_jobController.text);
    workplaceSink.add(_workplaceController.text);
  }

  void handleUpdateProfileError(Object error) {
    if (error is ValidationException) {
      switch (error.errorCode) {
        case ExceptionErrorCode.invalidPhone:
          _setPhoneError(error.message);
          break;
        case ExceptionErrorCode.invalidName:
          _setNameError(error.message);
          break;
        case ExceptionErrorCode.invalidJob:
          _setJobError(error.message);
          break;
        case ExceptionErrorCode.invalidWorkplace:
          _setWorkplaceError(error.message);
          break;
        case ExceptionErrorCode.invalidDob:
          _setDobError(error.message);
          break;
        default:
          break;
      }
    }
    else if (error is ResponseException) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Có lỗi xảy ra'),
            content: Text(error.message),
            actions: <Widget>[
              TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () => Navigator.of(context).pop()
              ),
            ],
          );
        },
      );
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hệ thống đang bận'),
            content: const Text('Vui lòng thử lại sau'),
            actions: <Widget>[
              TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () => Navigator.of(context).pop()
              ),
            ],
          );
        },
      );
    }
  }

  void handleAddImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String imagePath = result.paths[0]!;
      MultipartFile profileImageFile = await MultipartFile.fromPath(
        'profileImage',
        imagePath,
        contentType: MediaType('image', imagePath.substring(imagePath.lastIndexOf('.') + 1))
      );
      _userService.updateProfileImage(profileImageFile)
        .then((imageUrl) => _setPreviewUploadedImage(imageUrl))
        .catchError(handleUpdateProfileError);
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _nameController.dispose();
    _sexController.dispose();
    _phoneController.dispose();
    _jobController.dispose();
    _workplaceController.dispose();
    super.dispose();
  }
}