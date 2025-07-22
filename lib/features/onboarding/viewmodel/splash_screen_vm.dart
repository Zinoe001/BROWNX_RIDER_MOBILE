import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/router/router.dart';

class SplashViewModel extends BaseChangeNotifierViewModel {
  final LocalCache _localCache;
  SplashViewModel(this._localCache);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;

  Future<void> initialise() {
    bool isLoggedIn = _localCache.getToken() != null;
    log(_localCache.getToken().toString());
    debugPrint('User data *********** ${_localCache.getUserData()}');
    if (isLoggedIn) {
      return _navigationService
          .navigateAndClearStack(NavigatorRoutes.dashboardView);
    } else {
      return _navigationService.navigateAndClearStack(NavigatorRoutes.onboarding);
    }
  }
}
