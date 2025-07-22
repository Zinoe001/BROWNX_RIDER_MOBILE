
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/data/model/model.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NetworkService networkService;
  final LocalCache localCache;
  final AppLogger _logger = const AppLogger(AuthRepositoryImpl);

  AuthRepositoryImpl({required this.networkService, required this.localCache});

  @override
  Future<void> otpVerification({
    required String email,
    required String code,
  }) async {
    await networkService.post(
      ApiRoute.otpVerification,
      data: {'email': email, 'code': code},
    );
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String ownAVehicle,
    String? vehicleName,
    String? plateNumber,
    String? vehicleColor,
    String? stateOfVehicle,
    String? code,
  }) async {
    await networkService.post(
      ApiRoute.signUp,
      data: {
        "email": email,
        "name": name,
        "password": password,
        "confirmPassword": confirmPassword,
        "role": role,
        "ownAVehicle": ownAVehicle,
        "vehicleName": vehicleName ?? "",
        "vehicleColor": vehicleColor ?? "",
        "plateNumber": plateNumber ?? "",
        "stateOfVehicle": stateOfVehicle ?? "",
        "code": code ?? "",
      },
    );
  }

  @override
  Future<ApiResponse<AuthResponse>> login({
    required String name,
    required String password,
  }) async {
    final res = await networkService.post(
      ApiRoute.login,
      data: {'name': name, 'password': password},
    );
    _logger.d(res);
    
    return ApiResponse.fromJson(
      res.data, // Extract the JSON data from the response
      parser: (json) {
        return AuthResponse.fromJson(json["data"]);
      },
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await networkService.post(ApiRoute.forgotPassword, data: {"email": email});
  }

  @override
  Future<void> forgotPasswordVerification({
    required String email,
    required String code,
  }) async {
    await networkService.post(
      ApiRoute.forgotPasswordVerification,
      data: {'email': email, 'code': code},
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    await networkService.patch(
      ApiRoute.resetPassword,
      data: {"email": email, "password": password},
    );
  }

  @override
  Future<void> resendCode({required String email}) async {
    await networkService.post(ApiRoute.resendCode, data: {"email": email});
  }
}

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(
    networkService: ref.read(networkServiceProvider),
    localCache: ref.read(localCacheProvider),
  );
});
