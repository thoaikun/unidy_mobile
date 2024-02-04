import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:unidy_mobile/bloc/network_detect_cubit.dart';
import 'package:unidy_mobile/config/app_preferences.dart';
import 'package:unidy_mobile/config/http_client.dart';
import 'package:unidy_mobile/models/local_data_model.dart';
import 'package:unidy_mobile/screens/authentication/login_screen.dart';
import 'package:unidy_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:unidy_mobile/screens/organization/home/organization_home_screen.dart';
import 'package:unidy_mobile/screens/user/home/home_screen_container.dart';
import 'package:unidy_mobile/screens/user/volunteer_categories_selection/volunteer_categories_selection_screen.dart';

class PlaceholderScreen extends StatefulWidget {
  const PlaceholderScreen({super.key});

  @override
  State<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends State<PlaceholderScreen> {
  AppPreferences appPreferences = GetIt.instance<AppPreferences>();
  HttpClient httpClient = GetIt.instance<HttpClient>();
  dynamic networkDetectSubscription;

  @override
  void initState() {
    super.initState();
    _checkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    NetworkDetectState networkDetectState = context.watch<NetworkDetectCubit>().state;
    if (networkDetectState == NetworkDetectState.networkDetectDisconnected) {
      return _buildNetworkLoss();
    }

    return FutureBuilder(
      future: _isLogin(),
      builder: (context, snapshot) {
        if (snapshot.data?.isFirstTimeOpenApp == true) {
          return const OnboardingScreen();
        }

        switch (snapshot.data?.accountMode) {
          case AccountMode.user:
          case AccountMode.sponsor:
            return const PopScope(canPop: false, child: HomeScreenContainer());
          case AccountMode.organization:
            return const PopScope(canPop: false, child: OrganizationHomeScreen() );
          case AccountMode.none:
            return const PopScope(canPop: false, child: LoginScreen() );
          default:
            return _buildPlaceHolder();
        }
      }
    );
  }

  Widget _buildPlaceHolder() {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: MediaQuery.of(context).size.height / 2 - 40,
                left: MediaQuery.of(context).size.width / 2 - 40,
                child: Image.asset(
                  'assets/imgs/logo/logo_1.png',
                  width: 80,
                )
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.catching_pokemon_outlined),
                            SizedBox(width: 10),
                            Text('Đang lấy dữ liệu')
                          ],
                        ),
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 3)
                        )
                      ],
                    )
                ))
          ],
        )
    );
  }

  Widget _buildNetworkLoss() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 40,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Image.asset(
              'assets/imgs/logo/logo_1.png',
              width: 80,
            )
          ),
          Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.wifi_off_rounded),
                    SizedBox(width: 10),
                    Text('Bạn đang ngoại tuyến')
                  ],
                ),
                SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 3)
                )
              ],
            )
          ))
        ],
      )
    );
  }
  
  Future<LocalData> _isLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    String? data = appPreferences.getString('localData');

    if (data != null) {
      Map<String, dynamic> json = jsonDecode(data);
      LocalData localData = LocalData.fromJson(json);
      if (localData.accessToken != null) {
        httpClient.addHeader('Authorization', 'Bearer ${localData.accessToken}');
      }
      return localData;
    }
    return LocalData(null, null, true, false, 'none');
  }

  void _checkNetwork() {
    Connectivity().checkConnectivity()
      .then((ConnectivityResult value) {
        switch(value) {
          case ConnectivityResult.mobile:
          case ConnectivityResult.wifi:
            context.read<NetworkDetectCubit>().setNetworkDetectConnected(NetworkDetectState.networkDetectConnected);
            break;
          default:
            context.read<NetworkDetectCubit>().setNetworkDetectConnected(NetworkDetectState.networkDetectDisconnected);
            break;
        }
      });
    networkDetectSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch(result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          context.read<NetworkDetectCubit>().setNetworkDetectConnected(NetworkDetectState.networkDetectConnected);
          break;
        default:
          context.read<NetworkDetectCubit>().setNetworkDetectConnected(NetworkDetectState.networkDetectDisconnected);
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    networkDetectSubscription.cancel();
  }
}
