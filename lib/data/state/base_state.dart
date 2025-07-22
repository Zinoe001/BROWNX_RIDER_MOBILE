import 'package:flutter_utils/flutter_utils.dart';

abstract class BaseState {
  late final _logger = const AppLogger(BaseState);

  void handleError(Object e, [Object? stackTrace]) {
    if (e is Failure) throw e;
    _logger.e(e);
    if (stackTrace != null) _logger.i(stackTrace);
  }
}
