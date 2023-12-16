import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkDetectState {
  networkDetectConnected,
  networkDetectDisconnected
}

class NetworkDetectCubit extends Cubit<NetworkDetectState> {
  NetworkDetectCubit() : super(NetworkDetectState.networkDetectConnected);

  void setNetworkDetectConnected(NetworkDetectState state) {
    emit(state);
  }
}