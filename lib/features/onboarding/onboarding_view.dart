import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';
import 'package:rider_mobile/core/router/router.dart';
import 'package:rider_mobile/features/onboarding/components/onboarding_item.dart';
import 'package:rider_mobile/widgets/widgets.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  final List<OnBoardingItem> onboardingItems = [
    OnBoardingItem(
      img: Image.asset(ImageAsset.introCard1),
      text: 'Deliver with ',
      text2: 'Riders.',
    ),
    OnBoardingItem(
      img: Image.asset(ImageAsset.introCard2),
      text: 'Deliver with ',
      text2: 'Cyclers.',
    ),
    OnBoardingItem(
      img: Image.asset(ImageAsset.introCard3),
      text: 'Easy ',
      text2: 'Navigation',
    ),
  ];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: Column(
            children: [
              pageIndex == 2
                  ? Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _carouselController.jumpToPage(0);
                        },
                        child: SvgPicture.asset(SvgAsset.arrowLeft),
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      SvgPicture.asset(SvgAsset.logoWhite),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _carouselController.nextPage();
                        },
                        child: SvgPicture.asset(SvgAsset.arrowRight),
                      ),
                    ],
                  ),
              pageIndex == 2 ? const Gap.h(62) : const Gap.h(92),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CarouselSlider(
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          autoPlay: true,
                          onPageChanged: (index, reason) async {
                            if (mounted) {
                              setState(() {
                                pageIndex = index;
                              });
                            }
                          },
                          aspectRatio: 1 / 1.1,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                        ),
                        items:
                            onboardingItems.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Center(child: i.img);
                                },
                              );
                            }).toList(),
                      ),
                    ),
                    const Gap.h(40),
                    Text.rich(
                      TextSpan(
                        text: onboardingItems[pageIndex].text,
                        style: headingStyle6.copyWith(
                          fontSize: 14,
                          color: AppColors.lightgrey,
                        ),
                        children: [
                          TextSpan(
                            text: onboardingItems[pageIndex].text2,
                            style: headingStyle4.copyWith(
                              fontSize: 14,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Indicator(selected: pageIndex == 0),
                  const Gap.w(36),
                  _Indicator(selected: pageIndex == 1),
                  const Gap.w(36),
                  _Indicator(selected: pageIndex == 2),
                ],
              ),
              const Gap.h(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AppButton(
                      onTap: () {
                        _navigationService.navigateAndClearStack(
                          NavigatorRoutes.login,
                        );
                      },
                      title: "Log In",
                      color: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ),
                  Gap.w20,
                  Expanded(
                    child: AppButton(
                      onTap: () {
                        _navigationService.navigateAndClearStack(
                          NavigatorRoutes.signUp,
                        );
                      },
                      title: "Sign Up",
                      color: AppColors.lightgrey,
                    ),
                  ),
                ],
              ),
              const Gap.h(85),
            ],
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({this.selected = false});

  final bool selected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        color: selected ? AppColors.white : AppColors.lightgrey,
      ),
      height: 4,
      width: 38,
    );
  }
}
