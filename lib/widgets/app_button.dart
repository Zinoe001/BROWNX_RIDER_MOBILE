import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider_mobile/widgets/app_colors.dart';
import 'package:rider_mobile/widgets/text/app_text.dart';



class AppButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String? icon;
  final Color? iconColor;
  final Color? textColor;
  final String title;
  final bool disable;

  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.icon,
    this.iconColor,
    this.textColor,
    this.disable = false,
  });

  const AppButton.white({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.iconColor,
    this.disable = true,
  })  : color = AppColors.white,
        textColor = AppColors.black;

  const AppButton.black({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.iconColor,
    this.disable = false,
  })  : color = AppColors.black,
        textColor = AppColors.white;

  const AppButton.primary({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.iconColor,
    this.disable = false,
  })  : color = AppColors.primary,
        textColor = AppColors.white;

  const AppButton.grey({
    super.key,
    required this.title,
    this.onTap,
    this.icon,
    this.iconColor,
    this.disable = false,
  })  : color = AppColors.lightgrey,
        textColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            backgroundColor: color,
            iconColor: iconColor,
            side: disable ? const BorderSide() : BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.r)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? SvgPicture.asset(icon!,
                    height: 20,
                    width: 20,
                    // ignore: deprecated_member_use
                    color: iconColor ?? Colors.black)
                : const SizedBox.shrink(),
            icon != null ? SizedBox(width: 20.h) : const SizedBox.shrink(),
            AppText.button(
              title,
              color: textColor,
              centered: true,
              fontSize: 14.h,
            
            ),
          ],
        ),
      ),
    );
  }
}
