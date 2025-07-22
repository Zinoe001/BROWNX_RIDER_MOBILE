// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider_mobile/widgets/app_colors.dart';

class AppFlushBar {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late final BuildContext context;
  static final AppFlushBar instance = AppFlushBar._();
  AppFlushBar._();

  init(BuildContext context) {
    this.context = context;
  }

  /// show success indication
  void showSuccess({
    required String message,
    String? title = "Successful!",
    Duration? duration,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.all(8.w),
      borderRadius: BorderRadius.circular(12.r),
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.green,
      titleText: Text(
        title!,
        style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 14.sp,
        ),
      ),
    ).show(navigatorKey.currentContext!);
  }


  // void showNotification({
  //   //required BuildContext context,
  //   required String message,
  //   String? title,
  //   Color? color,
  //   Duration? duration,
  // }) {
  //   final context = navigatorKey.currentContext;
  //   if (context == null) return;
  //   Flushbar(
  //     flushbarPosition: FlushbarPosition.TOP,
  //     duration: duration ?? const Duration(seconds: 3),
  //     margin: const EdgeInsets.all(12),
  //     padding: EdgeInsets.all(8.w),
  //     borderRadius: BorderRadius.circular(12.r),
  //     backgroundColor: Colors.white,
  //     leftBarIndicatorColor: Colors.blue,
  //     titleText: Text(
  //       title!,
  //       style: TextStyle(
  //         color: Colors.blue.shade700,
  //         fontWeight: FontWeight.bold,
  //         fontSize: 16.sp,
  //       ),
  //     ),
  //     messageText: Text(
  //       message,
  //       style: TextStyle(
  //         color: Colors.grey.shade700,
  //         fontSize: 14.sp,
  //       ),
  //     ),
  //   ).show(context);
  // }

  void showError({
    required String message,
    String title = "Error",
    Duration? duration,
    Color? color,
  })async {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    await Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.all(8.w),
      borderRadius: BorderRadius.circular(12.r),
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.red,
      titleText: Text(
        title,
        style: TextStyle(
          color: Colors.red.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 14.sp,
        ),
      ),
    ).show(navigatorKey.currentContext!);
  }

  void showGeneric({
    //required BuildContext context,
    required String message,
    String? title,
    Color? color,
    Duration? duration,
  }) {
    Flushbar<dynamic>(
      flushbarPosition: FlushbarPosition.TOP,
      duration: duration ?? const Duration(seconds: 5),
      backgroundColor: color ?? AppColors.primary,
      // icon: Icon(
      //   Icons.info_outline,
      //   size: 28,
      //   color: Colors.grey.shade100,
      // ),
      // leftBarIndicatorColor: Colors.grey.shade100,
      shouldIconPulse: false,
      // backgroundGradient: LinearGradient(
      //   colors: [
      //     Colors.green.shade800,
      //     Colors.greenAccent.shade700,
      //     AppColors.primaryColor.shade900,
      //   ],
      //   // stops: [0.6, 1],
      // ),
      // boxShadows: const [
      //   BoxShadow(
      //     color: Colors.black45,
      //     offset: Offset(3, 3),
      //     blurRadius: 3,
      //   ),
      // ],
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(8),
      message: message,
      title: title,
    ).show(navigatorKey.currentContext!);
  }
}

class FlushBarLayer extends StatefulWidget {
  const FlushBarLayer({super.key, required this.child});

  final Widget child;

  @override
  State<FlushBarLayer> createState() => _FlushBarLayerState();
}

class _FlushBarLayerState extends State<FlushBarLayer> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
