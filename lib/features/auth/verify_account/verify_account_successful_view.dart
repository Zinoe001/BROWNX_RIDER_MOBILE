import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/widgets/widgets.dart';

class VerifyAccountSuccessfulView extends ConsumerWidget {
  VerifyAccountSuccessfulView({super.key});

  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AuthBG(
        // showBack: true,
        // showForward: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(
              //   SvgAsset.logoBlack,
              //   height: 46,
              //   width: 46,
              // ),
              Gap.h12,
              AppText.h1(
                "Verify account",
              ),
              Gap.h12,
              SvgPicture.asset(SvgAsset.tickWhite),
              Gap.h12,
              AppText.h1(
                "Account is Verified",
              ),
              const Gap.h(65),
              AppButton(
                title: "Explore BrownX",
                onTap: () {
                  _navigationService.navigateAndClearStack(NavigatorRoutes.login);
                },
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
