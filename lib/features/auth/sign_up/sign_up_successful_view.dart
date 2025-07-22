import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/features/auth/sign_up/viem_model/sign_up_successful_vm.dart';
import 'package:rider_mobile/widgets/widgets.dart';


final _signUpSuccessfulViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => SignUpSuccessfulViewModel(),
);

class SignUpSuccessfulView extends ConsumerStatefulWidget {
  const SignUpSuccessfulView({
    super.key,
    required this.email,
  });
  final String email;
  @override
  ConsumerState<SignUpSuccessfulView> createState() =>
      _SignUpSuccessfulViewState();
}

class _SignUpSuccessfulViewState extends ConsumerState<SignUpSuccessfulView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5),
        () => ref.read(_signUpSuccessfulViewModel).isDone(email: widget.email));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBG(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgAsset.logoWhite,
                height: 46,
                width: 46,
                color: AppColors.black,
              ),
              Gap.h12,
              AppText.h1("Create account", fontSize: 22),
              Gap.h12,
              SvgPicture.asset(SvgAsset.tickWhite),
              Gap.h12,
              AppText.h1(
                "All done",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
