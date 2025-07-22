import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/features/auth/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _forgotPasswordViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => ForgotPasswordViewModel(ref.read(authRepositoryProvider)),
);

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_forgotPasswordViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          showBack: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                      "Create Account",
                      color: AppColors.black,
                      fontSize: 22,
                    ),
                    const Gap.h(75),
                    Loader(color: AppColors.black),
                    const Gap.h(45),
                    AppText.h1(
                      "Verifying....",
                      fontSize: 22,
                      color: AppColors.black,
                    ),
                  ],
                );
              },
              idle: () {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
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
                        Gap.h18,
                        AppTextField(
                          controller: emailController,
                          hint: "E-mail",
                          validator:
                              (value) => Validator.email(emailController.text),
                        ),
                        const Gap.h(50),
                        AppButton.black(
                          title: "Submit",
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            model.forgotPassword(email: emailController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (e) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
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
                        Gap.h18,
                        AppTextField(
                          controller: emailController,
                          hint: "E-mail",
                          validator:
                              (value) => Validator.email(emailController.text),
                        ),
                        const Gap.h(50),
                        AppButton.black(
                          title: "Submit",
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            model.forgotPassword(email: emailController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
