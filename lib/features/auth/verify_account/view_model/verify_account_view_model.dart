import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';

class VerifyAccountViewModel extends BaseChangeNotifierViewModel {
  final AuthRepository _authRepository;
  VerifyAccountViewModel(this._authRepository);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;

  verify({
    required String email,
    required String code,
    required bool isPassword,
  }) async {
    try {
      Future.delayed(
        const Duration(seconds: 1),
        () => changeBaseState(const ViewModelState.busy()),
      );
      if (isPassword) {
        await _authRepository.forgotPasswordVerification(
          email: email,
          code: code,
        );
        changeBaseState(const ViewModelState.idle());
        _navigationService.navigateTo(
          NavigatorRoutes.createNewPasswordView,
          extra: {RoutingArgumentKey.email: email},
        );
      } else {
        await _authRepository.otpVerification(email: email, code: code);
        changeBaseState(const ViewModelState.idle());
        _navigationService.navigateAndClearStack(
          NavigatorRoutes.verifyAccountSuccessfulView,
        );
      }
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }

  resendCode({required String email}) async {
    await _authRepository.resendCode(email: email);
  }
}
