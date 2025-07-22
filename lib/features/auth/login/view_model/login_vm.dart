import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/data/state/user_state.dart';

class LoginViewModel extends BaseChangeNotifierViewModel {
  final AuthRepository _authRepository;
  final UserState _userState;
  LoginViewModel(this._authRepository, this._userState);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;

  login({required String name, required String password}) async {
    try {
      changeBaseState(const ViewModelState.busy());
      await _authRepository.login(name: name, password: password);
      changeBaseState(const ViewModelState.idle());
      _userState.getUserDetails();
      _navigationService.navigateAndClearStack(NavigatorRoutes.dashboardView);
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }
}
