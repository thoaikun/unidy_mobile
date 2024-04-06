import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unidy_mobile/models/organization_model.dart';

class OrganizationProfileCubit extends Cubit<Organization> {
  OrganizationProfileCubit() : super(Organization(
    userId: 0,
    organizationName: '',
    address: '',
    phone: '',
    email: '',
    country: '',
    firebaseTopic: '',
    image: '',
    isFollow: false,
    overallFigure: null
  ));

  void setProfile(Organization organization) {
    emit(organization);
  }

  void changeProfile(Map<String, dynamic> payload) {
    Organization newProfile = Organization(
      userId: state.userId,
      organizationName: payload['organizationName'] ?? state.organizationName,
      address: payload['address'] ?? state.address,
      phone: payload['phone'] ?? state.phone,
      email: payload['email'] ?? state.email,
      country: payload['country'] ?? state.country,
      firebaseTopic: payload['firebaseTopic'] ?? state.firebaseTopic,
      image: payload['image'] ?? state.image,
      isFollow: payload['isFollow'] ?? state.isFollow,
      overallFigure: payload['overallFigure'] ?? state.overallFigure
    );
    emit(newProfile);
  }

  void changeProfileImage(String imageUrl) {
    Organization newProfile = Organization(
      userId: state.userId,
      organizationName: state.organizationName,
      address: state.address,
      phone: state.phone,
      email: state.email,
      country: state.country,
      firebaseTopic: state.firebaseTopic,
      image: imageUrl,
      isFollow: state.isFollow,
      overallFigure: state.overallFigure
    );
    emit(newProfile);
  }

  void cleanProfile() {
    emit(Organization(
      userId: 0,
      organizationName: '',
      address: '',
      phone: '',
      email: '',
      country: '',
      firebaseTopic: '',
      image: '',
      isFollow: false,
      overallFigure: null
    ));
  }
}