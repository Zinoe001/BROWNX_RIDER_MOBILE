import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/data/state/user_state.dart';
import 'package:rider_mobile/features/auth/login/view_model/login_vm.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _loginViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => LoginViewModel(ref.read(authRepositoryProvider),
    ref.read(userStateProvider),
  ),
);
class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {
  final List<String> icons = [
    SvgAsset.google,
    SvgAsset.apple,
    SvgAsset.facebook,
  ];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_loginViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                      AppText.h1("Hi, Welcome",
                          color: AppColors.black, fontSize: 22),
                      const Gap.h(75),
                      Loader(
                        color: AppColors.black,
                      ),
                      const Gap.h(45),
                      AppText.h1("Loading...",
                          fontSize: 22, color: AppColors.black),
                    ],
                  );
                },
                idle: () {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SvgAsset.logoWhite,
                              height: 35,
                              width: 35,
                              // ignore: deprecated_member_use
                              color: AppColors.black),
                          Gap.h12,
                          AppText.h1("Hi, Welcome",
                              color: AppColors.black, fontSize: 22),
                          Gap.h18,
                          AppTextField(
                            controller: nameController,
                            hint: "Name",
                            validator: (value) => Validator.fullname(
                              nameController.text,
                            ),
                          ),
                          Gap.h30,
                          AppTextField(
                            controller: passwordController,
                            isPassword: true,
                            hint: "Password",
                            validator: (value) => Validator.password(
                              passwordController.text,
                            ),
                          ),
                          Gap.h22,
                          Row(children: [
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  _navigationService.navigateTo(
                                      NavigatorRoutes.forgotPassword);
                                },
                                child: AppText.h6("Forgot Password?",
                                    fontSize: 14, color: AppColors.black))
                          ]),
                          const Gap.h(30),
                          AppButton.black(
                              title: "Log in",
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                model.login(
                                  name: nameController.text,
                                  password: passwordController.text,
                                );
                              }),
                          const Gap.h(20),
                          AppText.h6("or log in with",
                              fontSize: 14, color: AppColors.black),
                          const Gap.h(25),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...List.generate(
                                        icons.length,
                                        (index) => GestureDetector(
                                              child: Container(
                                                  height: 65,
                                                  width: 65,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              AppColors.black),
                                                  child: Center(
                                                      child: SvgPicture.asset(
                                                          icons[index]))),
                                            ))
                                  ])),
                          const Gap.h(23),
                          GestureDetector(
                            onTap: () {
                              _navigationService
                                  .navigateAndClearStack(NavigatorRoutes.signUp);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Don’t have an account, ",
                                style: headingStyle6.copyWith(
                                    fontSize: 14, color: AppColors.black),
                                children: [
                                  TextSpan(
                                      text: "Sign up",
                                      style: headingStyle4.copyWith(
                                          fontSize: 14,
                                          color: AppColors.primary))
                                ],
                              ),
                            ),
                          ),
                        ]),
                  );
                },
                error: (e) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SvgAsset.logoWhite,
                              height: 35,
                              width: 35,
                              // ignore: deprecated_member_use
                              color: AppColors.black),
                          Gap.h12,
                          AppText.h1("Hi, Welcome",
                              color: AppColors.black, fontSize: 22),
                          Gap.h18,
                          AppTextField(
                            controller: nameController,
                            hint: "Name",
                            validator: (value) => Validator.fullname(
                              nameController.text,
                            ),
                          ),
                          Gap.h30,
                          AppTextField(
                            controller: passwordController,
                            hint: "Password",
                            isPassword: true,
                            validator: (value) => Validator.password(
                              passwordController.text,
                            ),
                          ),
                          Gap.h22,
                          Row(children: [
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  _navigationService.navigateTo(
                                      NavigatorRoutes.forgotPassword);
                                },
                                child: AppText.h6("Forgot Password?",
                                    fontSize: 14, color: AppColors.black))
                          ]),
                          const Gap.h(30),
                          AppButton.black(
                              title: "Log in",
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                model.login(
                                  name: nameController.text,
                                  password: passwordController.text,
                                );
                              }),
                          const Gap.h(20),
                          AppText.h6("or log in with",
                              fontSize: 14, color: AppColors.black),
                          const Gap.h(25),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...List.generate(
                                        icons.length,
                                        (index) => Container(
                                            height: 65,
                                            width: 65,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.black),
                                            child: Center(
                                                child: SvgPicture.asset(
                                                    icons[index]))))
                                  ])),
                          const Gap.h(23),
                          GestureDetector(
                            onTap: () {
                              _navigationService
                                  .navigateAndClearStack(NavigatorRoutes.signUp);
                            },
                            child: Text.rich(
                              TextSpan(
                                text: "Don’t have an account, ",
                                style: headingStyle6.copyWith(
                                    fontSize: 14, color: AppColors.black),
                                children: [
                                  TextSpan(
                                      text: "Sign up",
                                      style: headingStyle4.copyWith(
                                          fontSize: 14,
                                          color: AppColors.primary))
                                ],
                              ),
                            ),
                          ),
                        ]),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
