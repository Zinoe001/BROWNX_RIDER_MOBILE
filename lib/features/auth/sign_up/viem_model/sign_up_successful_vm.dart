import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/router/router.dart';

class SignUpSuccessfulViewModel extends BaseChangeNotifierViewModel {
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;

  Future<void> isDone({required String email}) {
    return _navigationService.navigateTo(
      NavigatorRoutes.verifyAccountView,
      extra: {
        RoutingArgumentKey.email: email,
        RoutingArgumentKey.password: false,
      },
    );
  }
}
