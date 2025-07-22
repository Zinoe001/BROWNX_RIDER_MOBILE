import 'dart:convert';

AuthUser AuthUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String AuthUserToJson(AuthUser data) => json.encode(data.toJson());

class AuthUser {
  final String id;
  final String name;
  final String email;
  final String userReferralCode;
  final String? profileImage;
  final String role;
  final String? phoneNumber;
  final String? referredByCode;
  final bool ownAVehicle;
  final String vehicleName;
  final String plateNumber;
  final String vehicleColor;
  final String stateOfVehicle;

  AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.userReferralCode,
    this.profileImage,
    required this.role,
    this.phoneNumber,
    this.referredByCode,
    required this.ownAVehicle,
    required this.vehicleName,
    required this.plateNumber,
    required this.vehicleColor,
    required this.stateOfVehicle,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      userReferralCode: json['userReferralCode'] as String,
      profileImage: json['profileImage'] as String?,
      role: json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      referredByCode: json['referredByCode'] as String?,
      ownAVehicle: json['ownAVehicle'].toString().toLowerCase() == 'yes',
      vehicleName: json['vehicleName'] as String,
      plateNumber: json['plateNumber'] as String,
      vehicleColor: json['vehicleColor'] as String,
      stateOfVehicle: json['stateOfVehicle'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userReferralCode': userReferralCode,
      'profileImage': profileImage,
      'role': role,
      'phoneNumber': phoneNumber,
      'referredByCode': referredByCode,
      'ownAVehicle': ownAVehicle ? 'Yes' : 'No',
      'vehicleName': vehicleName,
      'plateNumber': plateNumber,
      'vehicleColor': vehicleColor,
      'stateOfVehicle': stateOfVehicle,
    };
  }
}
