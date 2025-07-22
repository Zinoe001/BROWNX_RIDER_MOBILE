import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class RiderDetailsView extends ConsumerStatefulWidget {
  const RiderDetailsView({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.type,
    this.id,
  });
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String? id;
  final String type;

  @override
  ConsumerState<RiderDetailsView> createState() => _RiderDetailsViewState();
}

class _RiderDetailsViewState extends ConsumerState<RiderDetailsView> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSelected = false;
  int selected = -1;
  String type = "";
  String condition = "";
  final List<String> workingConditions = [
    "Excellent",
    "Good",
    "In need of repair",
    "Damaged",
  ];
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(_signUpViewModel);
    type = widget.type == "Rider" ? "Motorcycle" : "Bicycle";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: AuthBG(
          showBack: true,
          // showForward: true,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.black,
                          ),
                          child: AppText.h6(
                            widget.type,
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                        Gap.h12,
                        AppText.h6(
                          "Enter $type information",
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: nameController,
                          hint: "$type Name",
                          validator:
                              (value) => Validator.singleName(
                                nameController.text,
                                "$type Name",
                              ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: numberController,
                          hint: "$type Number",
                          validator:
                              (value) => Validator.emptyField(
                                numberController.text,
                                "$type Number",
                              ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: colorController,
                          hint: "$type Color",
                          validator:
                              (value) => Validator.emptyField(
                                colorController.text,
                                "$type Color",
                              ),
                        ),
                        Gap.h20,
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 19,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.h6(
                                "Working condition",
                                fontSize: 14,
                                color: AppColors.darkgrey.withOpacity(0.5),
                              ),
                              Gap.h4,
                              const Divider(),
                              Gap.h4,
                              ...List.generate(
                                workingConditions.length,
                                (index) => Row(
                                  children: [
                                    AppText.h6(
                                      workingConditions[index],
                                      fontSize: 14,
                                      color:
                                          isSelected && index == selected
                                              ? AppColors.black
                                              : AppColors.darkgrey.withOpacity(
                                                0.5,
                                              ),
                                    ),
                                    const Spacer(),
                                    Checkbox(
                                      value: index == selected,
                                      activeColor: AppColors.black,
                                      side: BorderSide(
                                        color: const Color(0XFF6D6969),
                                        width: 1,
                                      ),
                                      onChanged: (active) {
                                        setState(() {
                                          isSelected = active!;
                                          selected = index;
                                          condition = workingConditions[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap.h28,
                        AppButton.black(
                          title: "Create account",
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            model.register(
                              name: widget.name,
                              email: widget.email,
                              password: widget.password,
                              confirmPassword: widget.confirmPassword,
                              ownAVehicle: "Yes",
                              vehicleName: nameController.text,
                              plateNumber: numberController.text,
                              vehicleColor: colorController.text,
                              stateOfVehicle: condition,
                              role: widget.type,
                            );
                          },
                        ),
                        const Gap.h(30),
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.black,
                          ),
                          child: AppText.h6(
                            widget.type,
                            fontSize: 20,
                            color: AppColors.white,
                          ),
                        ),
                        Gap.h12,
                        AppText.h6(
                          "Enter $type information",
                          fontSize: 14,
                          color: AppColors.black,
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: nameController,
                          hint: "$type Name",
                          validator:
                              (value) => Validator.singleName(
                                nameController.text,
                                "$type Name",
                              ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: numberController,
                          hint: "$type Number",
                          validator:
                              (value) => Validator.emptyField(
                                numberController.text,
                                "$type Number",
                              ),
                        ),
                        Gap.h20,
                        AppTextField(
                          controller: colorController,
                          hint: "$type Color",
                          validator:
                              (value) => Validator.emptyField(
                                colorController.text,
                                "$type Color",
                              ),
                        ),
                        Gap.h20,
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 19,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.h6(
                                "Working condition",
                                fontSize: 14,
                                color: AppColors.darkgrey.withOpacity(0.5),
                              ),
                              Gap.h4,
                              const Divider(),
                              Gap.h4,
                              ...List.generate(
                                workingConditions.length,
                                (index) => Row(
                                  children: [
                                    AppText.h6(
                                      workingConditions[index],
                                      fontSize: 14,
                                      color:
                                          isSelected && index == selected
                                              ? AppColors.black
                                              : AppColors.darkgrey.withOpacity(
                                                0.5,
                                              ),
                                    ),
                                    const Spacer(),
                                    Checkbox(
                                      value: index == selected,
                                      activeColor: AppColors.black,
                                      side: BorderSide(
                                        color: const Color(0XFF6D6969),
                                        width: 1,
                                      ),
                                      onChanged: (active) {
                                        setState(() {
                                          isSelected = active!;
                                          selected = index;
                                          condition = workingConditions[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap.h28,
                        AppButton.black(
                          title: "Create account",
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            model.register(
                              name: widget.name,
                              email: widget.email,
                              password: widget.password,
                              confirmPassword: widget.confirmPassword,
                              ownAVehicle: "Yes",
                              vehicleName: nameController.text,
                              plateNumber: numberController.text,
                              vehicleColor: colorController.text,
                              stateOfVehicle: condition,
                              role: widget.type,
                            );
                          },
                        ),
                        const Gap.h(30),
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
