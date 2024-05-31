import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity/connectivity.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectedState> {
  StreamSubscription? streamSubscription;
  ConnectivityBloc() : super(const ConnectedState(message: "init")) {
    on<OnConnectedWifi>((event, emit) =>
        emit(const ConnectedState(message: "Connecting To Wifi")));
    on<OnConnectedMobileData>((event, emit) =>
        emit(const ConnectedState(message: "Connecting To Mobile Data")));
    on<OnNotConnected>((event, emit) =>
        emit(const ConnectedState(message: "Lost Internet Connection")));

    streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        add(OnConnectedWifi());
      } else if (result == ConnectivityResult.mobile) {
        add(OnConnectedMobileData());
      } else {
        add(OnNotConnected());
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
