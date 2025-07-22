
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';

class ForgotPasswordViewModel extends BaseChangeNotifierViewModel {

  final AuthRepository _authRepository; 
  ForgotPasswordViewModel(this._authRepository);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  forgotPassword({
    required String email,
  }) async {
    try {
      changeBaseState(const ViewModelState.busy());
      await _authRepository.forgotPassword(
        email: email,
      );
      changeBaseState(const ViewModelState.idle());
      _navigationService.navigateTo(NavigatorRoutes.forgotPasswordSubmitted,
          extra: {RoutingArgumentKey.email: email});
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }
}
