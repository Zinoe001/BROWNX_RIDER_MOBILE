import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/widgets/widgets.dart';

class ForgotPasswordSubmittedView extends StatelessWidget {
  const ForgotPasswordSubmittedView({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    final MobileNavigationService navigationService =
        MobileNavigationService.instance;
    return Scaffold(
      body: AuthBG(
        showBack: true,
        // showForward: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgAsset.logoWhite,
                height: 35,
                width: 35,
                // ignore: deprecated_member_use
                color: AppColors.black,
              ),
              Gap.h12,
              AppText.h1("Forgot password", fontSize: 22),
              Gap.h30,
              AppText.h6(
                "Password recovery details has been sent to  the email ${email.substring(0, 4)}*******${email.split("@")[1]}",
                fontSize: 14,
                centered: true,
              ),
              Gap.h30,
              Image.asset(ImageAsset.mail),
              const Gap.h(36),
              AppButton.white(
                title: "Create new password",
                onTap:
                    () => navigationService.navigateAndClearStack(
                      NavigatorRoutes.verifyAccountView,
                      extra: {
                        RoutingArgumentKey.email: email,
                        RoutingArgumentKey.password: true,
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
