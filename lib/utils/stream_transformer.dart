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
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map((value) => Validation.validateInput(value));
  }
}