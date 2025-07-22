import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:rider_mobile/core/core.dart';

class AuthBG extends StatelessWidget {
  AuthBG({
    super.key,
    required this.child,
    this.showBack = false,
    this.showForward = false,
  });
  final Widget child;
  final bool showBack;
  final bool showForward;

  final MobileNavigationService _navigationService =
      MobileNavigationService.instance;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          color: Colors.black,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            showBack
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 37),
                    child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            _navigationService.goBack();
                          },
                          child: SvgPicture.asset(SvgAsset.arrowLeft))
                    ]))
                : showForward
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 48, vertical: 57),
                        child: Row(children: [
                          const Spacer(),
                          GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(SvgAsset.arrowRight))
                        ]))
                    : const SizedBox()
          ])),
      Positioned.fill(
          top: MediaQuery.of(context).size.height / 4,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0XFFEEECEC),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: child))
    ]);
  }
}
