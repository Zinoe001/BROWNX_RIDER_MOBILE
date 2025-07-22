import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/widgets/app_flushbar.dart';

extension X on BaseChangeNotifierViewModel {
  showErrorFlushbar({String? title, required String message}) {
    AppFlushBar.instance.showError(message: message, title: title ?? "");
  }

  showSuccessFlushbar(String? title, String message) {
    AppFlushBar.instance.showSuccess(message: message, title: title ?? "");
  }

  showGenericFlushbar({String? title, required String message}) {
    AppFlushBar.instance.showGeneric(message: message, title: title ?? "");
  }
}
