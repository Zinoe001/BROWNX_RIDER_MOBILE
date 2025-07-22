import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/features/auth/forgot_password/view_model/create_new_password_view_model.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _createNewPasswordViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => CreateNewPasswordViewModel(
    ref.read(authRepositoryProvider),
  ),
);
class CreateNewPasswordView extends ConsumerStatefulWidget {
  const CreateNewPasswordView({super.key, required this.email});
  final String email;
  @override
  ConsumerState<CreateNewPasswordView> createState() =>
      _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends ConsumerState<CreateNewPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_createNewPasswordViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          // showBack: true,
          // showForward: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: model.baseState.when(
              busy: () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgAsset.logoWhite,
                        height: 35,
                        width: 35,
                        // ignore: deprecated_member_use
                        color: AppColors.black),
                    Gap.h12,
                    AppText.h1("Create Account",
                        color: AppColors.black, fontSize: 22),
                    const Gap.h(75),
                    Loader(
                      color: AppColors.black,
                    ),
                    const Gap.h(45),
                    AppText.h1("Setting up",
                        fontSize: 22, color: AppColors.black),
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
                        SvgPicture.asset(SvgAsset.logoWhite,
                            height: 35,
                            width: 35,
                            // ignore: deprecated_member_use
                            color: AppColors.black),
                        Gap.h12,
                        AppText.h1("Create new password", fontSize: 22),
                        Gap.h12,
                        const Gap.h(30),
                        AppTextField(
                          controller: passwordController,
                          hint: "Password",
                        ),
                        Gap.h10,
                        AppText.h6(
                            "Password must contain uppercase, lowercase, special characters and numbers for your safety",
                            fontSize: 12),
                        const Gap.h(65),
                        AppButton(
                            title: "Submit",
                            onTap: () {
                              model.resetPassword(
                                email: widget.email,
                                password: passwordController.text,
                              );
                            },
                            color: AppColors.black,
                            textColor: AppColors.white)
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
                        SvgPicture.asset(SvgAsset.logoWhite,
                            height: 35,
                            width: 35,
                            // ignore: deprecated_member_use
                            color: AppColors.black),
                        Gap.h12,
                        AppText.h1("Create new password", fontSize: 22),
                        Gap.h12,
                        const Gap.h(30),
                        AppTextField(
                          controller: passwordController,
                          hint: "Password",
                        ),
                        Gap.h10,
                        AppText.h6(
                            "Password must contain uppercase, lowercase, special characters and numbers for your safety",
                            fontSize: 12),
                        const Gap.h(65),
                        AppButton(
                            title: "Submit",
                            onTap: () {
                              model.resetPassword(
                                email: widget.email,
                                password: passwordController.text,
                              );
                            },
                            color: AppColors.black,
                            textColor: AppColors.white)
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
