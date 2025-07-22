import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/features/auth/verify_account/view_model/verify_account_view_model.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _verifyAccountViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => VerifyAccountViewModel(ref.read(authRepositoryProvider)),
);

class VerifyAccountView extends ConsumerStatefulWidget {
  const VerifyAccountView({
    super.key,
    required this.email,
    required this.isPassword,
  });
  final String email;
  final bool isPassword;
  @override
  ConsumerState<VerifyAccountView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<VerifyAccountView> {
  final TextEditingController otpController = TextEditingController();

  // final NavigationService _navigationService = NavigationService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isCompleted = false;
  bool isErrorCompleted = false;
  bool isReceived = false;
  bool isReset = false;
  static const maxSeconds = 30; // Change this value to set the countdown time
  int secondsLeft = maxSeconds;
  Timer? timer;

  void startTimer() {
    timer?.cancel();
    secondsLeft = maxSeconds;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
        isReset = !isReset;
        setState(() {});
      }
    });
  }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_verifyAccountViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          // showBack: true,
          // showForward: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: model.baseState.when(
                  busy: () {
                    return Column(
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
                        AppText.h1(
                          "Verify Account",
                          color: AppColors.black,
                          fontSize: 22,
                        ),
                        const Gap.h(75),
                        Loader(color: AppColors.black),
                        const Gap.h(45),
                        AppText.h1(
                          "Verifying...",
                          fontSize: 22,
                          color: AppColors.black,
                        ),
                      ],
                    );
                  },
                  idle: () {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgAsset.logoWhite,
                          height: 46,
                          width: 46,
                          color: AppColors.black,
                        ),
                        Gap.h12,
                        AppText.h1("Verify Account", fontSize: 22),
                        Gap.h12,
                        AppText.h6(
                          "Type out the 4-digit code sent to the email ${widget.email.substring(0, 4)}*******${widget.email.split("@")[1]}",
                          fontSize: 14,
                        ),
                        Gap.h32,
                        PinCodeField(
                          otpController: otpController,
                          length: 4,
                          isCompleted: isCompleted,
                          onCompleted: (value) {
                            isCompleted = !isCompleted;
                            setState(() {});
                            model.verify(
                              email: widget.email,
                              code: value,
                              isPassword: widget.isPassword,
                            );
                          },
                        ),
                        Gap.h22,
                        if (isReset)
                          AppText.h6(
                            "Send code in 00:$secondsLeft",
                            fontSize: 12,
                          ),
                        Gap.h6,
                        GestureDetector(
                          onTap: () {
                            isReset = !isReset;
                            setState(() {});
                            startTimer();
                            model.resendCode(email: widget.email);
                          },
                          child: AppText.h6(
                            "Didn’t receive code? resend code",
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                  error: (e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgAsset.logoWhite,
                          height: 46,
                          width: 46,
                          color: AppColors.black,
                        ),
                        Gap.h12,
                        AppText.h1("Verify Account", fontSize: 22),
                        Gap.h12,
                        AppText.h6(
                          "Type out the 4-digit code sent to the email ${widget.email.substring(0, 4)}*******${widget.email.split("@")[1]}",
                          fontSize: 14,
                        ),
                        Gap.h32,
                        PinCodeField(
                          otpController: otpController,
                          length: 4,
                          isError: true,
                          isCompleted: isErrorCompleted,
                          onCompleted: (value) {
                            isErrorCompleted = !isErrorCompleted;
                            setState(() {});
                            model.verify(
                              email: widget.email,
                              code: value,
                              isPassword: widget.isPassword,
                            );
                          },
                        ),
                        Gap.h22,
                        AppText.h6(
                          "Wrong digits please try again",
                          fontSize: 16,
                        ),
                        const Gap.h(150),
                        if (isReset)
                          AppText.h6(
                            "Send code in 00:$secondsLeft",
                            fontSize: 12,
                          ),
                        Gap.h6,
                        GestureDetector(
                          onTap: () {
                            isReset = !isReset;
                            setState(() {});
                            startTimer();
                            model.resendCode(email: widget.email);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color:
                                  isReset
                                      ? AppColors.darkgrey
                                      : AppColors.black,
                            ),
                            child: AppText.button(
                              "Resend Code",
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
