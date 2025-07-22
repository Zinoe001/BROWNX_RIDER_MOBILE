
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';

class CreateNewPasswordViewModel extends BaseChangeNotifierViewModel {

  final AuthRepository _authRepository; 
  CreateNewPasswordViewModel(this._authRepository);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;

  resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      changeBaseState(const ViewModelState.busy());
      await _authRepository.resetPassword(email: email, password: password);
      changeBaseState(const ViewModelState.idle());
      _navigationService
          .navigateTo(NavigatorRoutes.createNewPasswordSuccessfulView);
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }
}
