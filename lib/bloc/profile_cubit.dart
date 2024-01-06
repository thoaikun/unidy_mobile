import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unidy_mobile/models/user_model.dart';

class ProfileCubit extends Cubit<User> {
  ProfileCubit() : super(User(
      userId: 0,
  ));

  void setProfile(User user) {
    emit(user);
  }

  void changeProfile(Map<String, dynamic> payload) {
    User newProfile = User(
        userId: state.userId,
        fullName: payload['fullName'] ?? state.fullName,
        address: payload['address'] ?? state.address,
        phone: payload['phone'] ?? state.phone,
        sex: payload['sex'] ?? state.sex,
        job: payload['job'] ?? state.job,
        role: payload['role'] ?? state.role,
        dayOfBirth: payload['dayOfBirth'] ?? state.dayOfBirth,
        workLocation: payload['workLocation'] ?? state.workLocation
    );
    emit(newProfile);
  }

  void changeProfileImage(String imageUrl) {
    User newProfile = User(
        userId: state.userId,
        fullName: state.fullName,
        address: state.address,
        phone: state.phone,
        sex: state.sex,
        job: state.job,
        role: state.role,
        dayOfBirth: state.dayOfBirth,
        workLocation: state.workLocation,
        image: imageUrl
    );
    emit(newProfile);
  }
}