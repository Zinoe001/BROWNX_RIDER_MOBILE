import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/widgets/widgets.dart';

class CreateNewPasswordSuccessfulView extends StatelessWidget {
  const CreateNewPasswordSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    final MobileNavigationService navigationService =
        MobileNavigationService.instance;
    return Scaffold(
      body: AuthBG(
        // showBack: true,
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
              AppText.h1("Create new password", fontSize: 22),
              const Gap.h(40),
              SvgPicture.asset(SvgAsset.tickWhite),
              Gap.h12,
              AppText.h1(
                "Password successfully created",
                centered: true,
                fontSize: 22,
              ),
              Gap.h20,
              AppButton(
                title: "Proceed to log in",
                onTap:
                    () => navigationService.navigateAndClearStack(
                      NavigatorRoutes.login,
                    ),
                color: AppColors.black,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
