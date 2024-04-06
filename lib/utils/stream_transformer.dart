import 'dart:async';
import 'validation_util.dart';

class EmailValidationTransformer extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((value) => Validation.validateEmail(value));
  }
}

class PasswordValidationTransformer extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((value) => Validation.validatePassword(value));
  }
}

class PhoneValidationTransformer extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((value) => Validation.validatePhone(value));
  }
}

class ValidationTransformer extends StreamTransformerBase<String, String> {
  String? validationType;
  ValidationTransformer({ this.validationType });

  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((value) => Validation.validateInput(value, validationType ?? 'input'));
  }
}

class ValidationSimilarPasswordTransformer extends StreamTransformerBase<List<String>, String> {
  @override
  Stream<String> bind(Stream<List<String>> stream) {
    return stream.map((value) => Validation.validateSimilarPassword(value[0], value[1]));
  }
}