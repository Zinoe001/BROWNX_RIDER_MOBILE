
import 'package:rider_mobile/data/model/model.dart';

class AuthResponse {
  final AuthUser user;
  final String token;
  final String refToken;

  AuthResponse({
    required this.user,
    required this.token,
    required this.refToken,
  });

  AuthResponse copyWith({
    AuthUser? user,
    String? token,
    String? refToken,
  }) =>
      AuthResponse(
        user: user ?? this.user,
        token: token ?? this.token,
        refToken: refToken ?? this.refToken,
      );

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        user: AuthUser.fromJson(json["user"]),
        token: json["token"],
        refToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "token": token,
        "refreshToken": refToken,
      };
}
