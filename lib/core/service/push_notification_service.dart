import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotificationService {
  // final _logger = appLogger(PushNotificationService);

  PushNotificationService._();
  static final PushNotificationService _i = PushNotificationService._();
  static PushNotificationService get instance => _i;

}
