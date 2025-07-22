import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';


class SignUpViewModel extends BaseChangeNotifierViewModel {
  final AuthRepository _authRepository;
  SignUpViewModel(this._authRepository);
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String ownAVehicle,
    required String vehicleName,
    required String plateNumber,
    required String vehicleColor,
    required String stateOfVehicle,
    String? code,
  }) async {
    try {
      changeBaseState(const ViewModelState.busy());
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        ownAVehicle: ownAVehicle,
        vehicleName: vehicleName,
        plateNumber: plateNumber,
        vehicleColor: vehicleColor,
        stateOfVehicle: stateOfVehicle,
        code: code,
      );
      changeBaseState(const ViewModelState.idle());
      _navigationService.replace(NavigatorRoutes.signUpSuccessful,
          extra: {RoutingArgumentKey.email: email});
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }

  registerForNo({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String ownAVehicle,
    String? code,
  }) async {
    try {
      changeBaseState(const ViewModelState.busy());
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        ownAVehicle: ownAVehicle,
        code: code, 
      );
      changeBaseState(const ViewModelState.idle());
      _navigationService.replace(NavigatorRoutes.signUpSuccessful,
          extra: {RoutingArgumentKey.email: email});
    } on Failure catch (e) {
      changeBaseState(ViewModelState.error(e));
      showErrorFlushbar(message: e.toString());
    }
  }
}
