class UserModel {
  final String id;
  final String name;
  final String email;
  final String? userReferralCode;
  final String? profileImage;
  final String role;
  final String? phoneNumber;
  final String? referredByCode;
  final String ownAVehicle;
  final String? vehicleName;
  final String? vehicleColor;
  final String? plateNumber;
  final String? stateOfVehicle;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.role,
    required this.ownAVehicle,
    this.userReferralCode,
    this.profileImage,
    this.phoneNumber,
    this.referredByCode,
    this.vehicleName,
    this.vehicleColor,
    this.plateNumber,
    this.stateOfVehicle,
  });

  UserModel copyWith({
    String? name,
    String? id,
    String? token,
    String? email,
    String? userReferralCode,
    String? profileImage,
    String? role,
    String? phoneNumber,
    String? referredByCode,
    String? ownAVehicle,
    String? vehicleName,
    String? vehicleColor,
    String? plateNumber,
    String? stateOfVehicle,
  }) =>
      UserModel(
        name: name ?? this.name,
        id: id ?? this.id,
        email: email ?? this.email,
        role: role ?? this.role,
        ownAVehicle: ownAVehicle ?? this.ownAVehicle,
        userReferralCode: userReferralCode ?? this.userReferralCode,
        profileImage: profileImage ?? this.profileImage,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        referredByCode: referredByCode ?? this.referredByCode,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleColor: vehicleColor ?? this.vehicleColor,
        plateNumber: plateNumber ?? this.plateNumber,
        stateOfVehicle: stateOfVehicle ?? this.stateOfVehicle,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        id: json["id"],
        email: json["email"],
        role: json["role"],
        ownAVehicle: json["ownAVehicle"],
        userReferralCode: json["userReferralCode"],
        profileImage: json["profileImage"],
        phoneNumber: json["phoneNumber"],
        referredByCode: json["referredByCode"],
        vehicleName: json["vehicleName"],
        vehicleColor: json["vehicleColor"],
        plateNumber: json["plateNumber"],
        stateOfVehicle: json["stateOfVehicle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
        "role": role,
        "ownAVehicle": ownAVehicle,
        "userReferralCode": userReferralCode,
        "profileImage": profileImage,
        "phoneNumber": phoneNumber,
        "referredByCode": referredByCode,
        "vehicleName": vehicleName,
        "vehicleColor": vehicleColor,
        "plateNumber": plateNumber,
        "stateOfVehicle": stateOfVehicle,
      };
}
