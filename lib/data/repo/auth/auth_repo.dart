import 'package:rider_mobile/data/model/model.dart';
import 'package:flutter_utils/flutter_utils.dart';

abstract class AuthRepository {
  Future<void> otpVerification({required String email, required String code});

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
  });

  Future<void> forgotPassword({required String email});
  Future<void> forgotPasswordVerification({
    required String email,
    required String code,
  });

  Future<void> resetPassword({required String email, required String password});

  Future<void> resendCode({required String email});

  Future<ApiResponse<AuthResponse>> login({
    required String name,
    required String password,
  });
}
