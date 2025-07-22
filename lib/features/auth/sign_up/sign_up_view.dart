import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/data/repo/auth/auth.dart';
import 'package:rider_mobile/features/auth/sign_up/viem_model/sign_up_vm.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/features/auth/components/auth_background.dart';
import 'package:rider_mobile/widgets/widgets.dart';

final _signUpViewModel = ChangeNotifierProvider.autoDispose(
  (ref) => SignUpViewModel(ref.read(authRepositoryProvider)),
);

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController agentIDController = TextEditingController();
  final TextEditingController reTypePasswordController =
      TextEditingController();

  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> type = ["Rider", "Cycler"];
  int typeindex = 0;
  bool isChecked = false;
  bool isYes = false;
  bool isNo = false;
  bool isValid = false;
  String isType = "Rider";
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_signUpViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          // showBack: true,
          // showForward: true,
          child: Form(
            key: _formKey,
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
                      Loader(color: AppColors.black, radius: 150),
                      const Gap.h(45),
                      AppText.h1(
                        "Setting up",
                        fontSize: 22,
                        color: AppColors.black,
                      ),
                    ],
                  );
                },
                idle: () {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
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
                        AppText.h1("Create Account", fontSize: 22),
                        Gap.h12,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                type.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      typeindex =
                                          index; // Update typeindex to the tapped index
                                      isType =
                                          type[index]; // Set isType based on the selected index
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color:
                                          index == typeindex
                                              ? AppColors.black
                                              : Colors.transparent,
                                    ),
                                    child: AppText.h6(
                                      "As ${type[index]}",
                                      fontSize: 20,
                                      color:
                                          index == typeindex
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: nameController,
                          hint: "Name",
                          validator: Validator.fullname,
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: emailController,
                          hint: "E-mail",
                          validator: Validator.email,
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: passwordController,
                          hint: "Password",
                          isPassword: true,
                          validator: Validator.password,
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: reTypePasswordController,
                          hint: "Re-type password",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please re-type your password";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        Gap.h18,
                        Container(
                          height: 62,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: AppText.h6(
                            "Do you have a Motorcycle or Bicycle",
                            fontSize: 14,
                            color: AppColors.black.withOpacity(0.35),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.h6(
                              "Yes",
                              fontSize: 14,
                              color:
                                  isYes ? AppColors.black : AppColors.darkgrey,
                            ),
                            Checkbox(
                              value: isYes,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isYes = active!;
                                  isNo = false;
                                });
                              },
                            ),
                            AppText.h6(
                              "No",
                              fontSize: 14,
                              color:
                                  isNo ? AppColors.black : AppColors.darkgrey,
                            ),
                            Checkbox(
                              value: isNo,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isNo = active!;
                                  isYes = false;
                                });
                              },
                            ),
                          ],
                        ),
                        Gap.h18,
                        AppTextField(
                          controller: agentIDController,
                          hint: "Sales Agent ID (optional)",
                          suffixIcon:
                              isValid
                                  ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    child: SvgPicture.asset(SvgAsset.tickGreen),
                                  )
                                  : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    child: SvgPicture.asset(
                                      SvgAsset.tickNoFill,
                                    ),
                                  ),
                          validCode: isValid,
                        ),
                        const Gap.h(28),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isChecked = active!;
                                });
                              },
                            ),
                            AppText.h6(
                              "I agree with all terms and policies",
                              fontSize: 14,
                              color:
                                  isChecked
                                      ? AppColors.black
                                      : AppColors.darkgrey,
                            ),
                          ],
                        ),
                        const Gap.h(35),
                        AppButton.black(
                          title: isNo ? "Create account" : "Proceed",
                          onTap: () {
                            if (!_formKey.currentState!.validate() ||
                                isChecked == false) {
                              return;
                            }
                            print(isType);
                            if (isYes) {
                              _navigationService.navigateTo(
                                NavigatorRoutes.riderDetails,
                                extra: {
                                  RoutingArgumentKey.email:
                                      emailController.text,
                                  RoutingArgumentKey.password:
                                      passwordController.text,
                                  RoutingArgumentKey.name: nameController.text,
                                  RoutingArgumentKey.confirmPassword:
                                      reTypePasswordController.text,
                                  RoutingArgumentKey.type: isType,
                                  RoutingArgumentKey.id: agentIDController.text,
                                },
                              );
                            } else {
                              model.registerForNo(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: reTypePasswordController.text,
                                ownAVehicle: "No",
                                role: isType,
                                code: agentIDController.text,
                              );
                            }
                          },
                        ),
                        const Gap.h(30),
                        GestureDetector(
                          onTap: () {
                            _navigationService.replace(NavigatorRoutes.login);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account, ",
                              style: headingStyle6.copyWith(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: headingStyle4.copyWith(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                error: (e) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
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
                        AppText.h1("Create Account", fontSize: 22),
                        Gap.h12,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                type.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      typeindex =
                                          index; // Update typeindex to the tapped index
                                      isType =
                                          type[index]; // Set isType based on the selected index
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 28,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                      color:
                                          index == typeindex
                                              ? AppColors.black
                                              : Colors.transparent,
                                    ),
                                    child: AppText.h6(
                                      "As ${type[index]}",
                                      fontSize: 20,
                                      color:
                                          index == typeindex
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: nameController,
                          hint: "Name",
                          validator:
                              (value) =>
                                  Validator.fullname(nameController.text),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: emailController,
                          hint: "E-mail",
                          validator:
                              (value) => Validator.email(emailController.text),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: passwordController,
                          hint: "Password",
                          isPassword: true,
                          validator:
                              (value) =>
                                  Validator.password(passwordController.text),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: reTypePasswordController,
                          hint: "Re-type password",
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please re-type your password";
                            }
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        Gap.h18,
                        Container(
                          height: 62,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: AppText.h6(
                            "Do you have a Motorcycle or Bicycle",
                            fontSize: 14,
                            color: AppColors.black.withOpacity(0.35),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.h6(
                              "Yes",
                              fontSize: 14,
                              color:
                                  isYes ? AppColors.black : AppColors.darkgrey,
                            ),
                            Checkbox(
                              value: isYes,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isYes = active!;
                                  isNo = false;
                                });
                              },
                            ),
                            AppText.h6(
                              "No",
                              fontSize: 14,
                              color:
                                  isNo ? AppColors.black : AppColors.darkgrey,
                            ),
                            Checkbox(
                              value: isNo,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isNo = active!;
                                  isYes = false;
                                });
                              },
                            ),
                          ],
                        ),
                        Gap.h18,
                        AppTextField(
                          controller: agentIDController,
                          hint: "Sales Agent ID (optional)",
                          suffixIcon:
                              isValid
                                  ? Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    child: SvgPicture.asset(SvgAsset.tickGreen),
                                  )
                                  : Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    child: SvgPicture.asset(
                                      SvgAsset.tickNoFill,
                                    ),
                                  ),
                          validCode: isValid,
                        ),
                        const Gap.h(28),
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              activeColor: AppColors.black,
                              side: BorderSide(
                                color: const Color(0XFF6D6969),
                                width: 1,
                              ),
                              onChanged: (active) {
                                setState(() {
                                  isChecked = active!;
                                });
                              },
                            ),
                            AppText.h6(
                              "I agree with all terms and policies",
                              fontSize: 14,
                              color:
                                  isChecked
                                      ? AppColors.black
                                      : AppColors.darkgrey,
                            ),
                          ],
                        ),
                        const Gap.h(35),
                        AppButton.black(
                          title: isNo ? "Create account" : "Proceed",
                          onTap: () {
                            if (!_formKey.currentState!.validate() ||
                                isChecked == false) {
                              return;
                            }
                            if (isYes) {
                              _navigationService.navigateTo(
                                NavigatorRoutes.riderDetails,
                                extra: {
                                  RoutingArgumentKey.email:
                                      emailController.text,
                                  RoutingArgumentKey.password:
                                      passwordController.text,
                                  RoutingArgumentKey.name: nameController.text,
                                  RoutingArgumentKey.confirmPassword:
                                      reTypePasswordController.text,
                                  RoutingArgumentKey.type: isType,
                                  RoutingArgumentKey.id: agentIDController.text,
                                },
                              );
                            } else {
                              model.registerForNo(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: reTypePasswordController.text,
                                ownAVehicle: "No",
                                role: isType,
                                code: agentIDController.text,
                              );
                            }
                          },
                        ),
                        const Gap.h(30),
                        GestureDetector(
                          onTap: () {
                            _navigationService.replace(NavigatorRoutes.login);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account, ",
                              style: headingStyle6.copyWith(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign in",
                                  style: headingStyle4.copyWith(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
